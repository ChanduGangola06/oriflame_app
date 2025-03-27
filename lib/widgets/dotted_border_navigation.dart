import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class DottedBorderNavigation extends StatefulWidget {
  final List<File> images;
  final int currentIndex;
  final Function(int) onIndexChanged;

  const DottedBorderNavigation({
    Key? key,
    required this.images,
    required this.currentIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  _DottedBorderNavigationState createState() => _DottedBorderNavigationState();
}

class _DottedBorderNavigationState extends State<DottedBorderNavigation> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      top: screenHeight * 0.3,
      right: screenWidth * 0.05,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff31313163),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DotsIndicator(
          dotsCount: widget.images.length,
          axis: Axis.vertical,
          position: widget.currentIndex.toDouble(),
          decorator: DotsDecorator(
            color: Colors.white,
            activeColor: Color(0xFF7EC086),
          ),
          onTap: (position) {
            widget.onIndexChanged(position);
          },
        ),
      ),
    );
  }
}
