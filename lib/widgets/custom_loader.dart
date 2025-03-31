// ignore_for_file: use_super_parameters, library_private_types_in_public_api, use_build_context_synchronously, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SalesLinkLoaderDialog extends StatefulWidget {
  final String shareContent;
  final String? fallbackText;

  const SalesLinkLoaderDialog({
    Key? key,
    required this.shareContent,
    this.fallbackText,
  }) : super(key: key);

  @override
  _SalesLinkLoaderDialogState createState() => _SalesLinkLoaderDialogState();
}

class _SalesLinkLoaderDialogState extends State<SalesLinkLoaderDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    // Auto-close dialog after 5 seconds and trigger share
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
        _shareOnPlatform('whatsapp');
      }
    });
  }

  void _shareOnPlatform(String platform) async {
    final Uri? shareUrl = _getShareUrl(platform);
    if (shareUrl != null) {
      try {
        if (!await launchUrl(shareUrl, mode: LaunchMode.externalApplication)) {
          await launchUrl(shareUrl, mode: LaunchMode.platformDefault);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $platform: $e')),
        );
      }
    }
  }

  Uri? _getShareUrl(String platform) {
    // Use fallback text if provided, otherwise use shareContent
    final String textToShare = widget.fallbackText ?? widget.shareContent;
    final encodedLink = Uri.encodeComponent(textToShare);

    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return Platform.isIOS
            ? Uri.parse('whatsapp://send?text=$encodedLink')
            : Uri.parse('https://wa.me/?text=$encodedLink');
      case 'instagram':
        return Uri.parse('instagram://share?text=$encodedLink');
      case 'facebook':
        return Uri.parse('fb://share/sheet?text=$encodedLink');
      case 'messenger':
        return Uri.parse('fb-messenger://share?link=$encodedLink');
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated Loader
            RotationTransition(
              turns: _rotationAnimation,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade100,
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade300,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Text
            Text(
              'Generating your sales link...',
              style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Progress Bar
            LinearProgressIndicator(
              backgroundColor: Colors.green.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
