// ignore_for_file: unused_element, unnecessary_nullable_for_final_variable_declarations, use_build_context_synchronously, use_full_hex_values_for_flutter_colors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_dialog.dart';
import '../widgets/custom_loader.dart';
import '../widgets/dotted_border_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String _savedText = '';
  final TextEditingController _dialogController = TextEditingController();
  int _currentImageIndex = 0;
  late PageController _pageController;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentImageIndex);
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage(
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85, // Compress images
      );
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final List<File> imageFiles =
            pickedFiles
                .take(3) // Take maximum 3 images
                .map((xfile) => File(xfile.path))
                .toList();

        setState(() {
          _selectedImages = imageFiles;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking images: $e')));
    }
  }

  void _showFullScreenDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => CustomDialog(
            controller: _dialogController,
            onSave: () {
              setState(() {
                _savedText = _dialogController.text;
              });
              Navigator.pop(context);
            },
            onClose: () {
              Navigator.pop(context);
            },
          ),
    );
  }

  @override
  void dispose() {
    _dialogController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _updateCurrentImageIndex(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('OriFlame'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10, top: 5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF7EC086),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  onPressed: _pickImages,
                  icon: Icon(Icons.camera_alt, size: 25, color: Colors.white),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Smart Post",
                    style: TextStyle(color: Color(0xFF7EC086)),
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  child: Text("Library", style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Communities",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Share and Win",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          _selectedImages.isEmpty
              ? Container()
              : SizedBox(
                height: screenHeight * 0.75,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _selectedImages.length,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index) {
                    _updateCurrentImageIndex(index);
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.file(
                          _selectedImages[index],
                          fit: BoxFit.cover,
                          height: screenHeight * 0.75,
                          width: screenWidth,
                        ),
                        Positioned(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.04,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: screenWidth * 0.92,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 55,
                                            height: 55,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              child: Image.network(
                                                'https://cdn-icons-png.flaticon.com/512/6858/6858504.png',
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(
                                                  'assets/images/Tag.png',
                                                  width: screenWidth * 0.4,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'High-converting in Oriflame Community',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 2,
                                        bottom: 2,
                                        left: 8,
                                        right: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Pick ${index + 1} of 3',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        DottedBorderNavigation(
                          images: _selectedImages,
                          currentIndex: _currentImageIndex,
                          onIndexChanged: (newIndex) {
                            // Optional: Add page controller navigation if needed
                            _pageController.animateToPage(
                              newIndex,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        Positioned(
                          bottom: screenHeight * 0.05,
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                          child: SizedBox(
                            width: screenWidth * 0.91,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _savedText.isEmpty
                                    ? Container()
                                    : Container(
                                      padding: EdgeInsets.only(
                                        top: 4,
                                        bottom: 4,
                                        left: 8,
                                        right: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF31313163),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Recommended: Bad Habits by Ed Sheeran',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                SizedBox(height: 5),
                                GestureDetector(
                                  onTap: _showFullScreenDialog,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: 4,
                                      bottom: 4,
                                      left: 8,
                                      right: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xff31313163),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        _savedText.isEmpty
                                            ? Text(
                                              'Add Caption',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                            : Text(
                                              _dialogController.text,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Quick Share to:',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            socialShare(
                                              'assets/images/instagram-empty.png',
                                              'instagram',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/instagram-filled.png',
                                              'instagram',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/facebook-empty.png',
                                              'facebook',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/facebook-filled.png',
                                              'facebook',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/messenger.png',
                                              'messenger',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/tiktok.png',
                                              'tiktok',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/whatsapp.png',
                                              'whatsapp',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/b.png',
                                              'b',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/telegram.png',
                                              'telegram',
                                              isPressed,
                                            ),
                                            socialShare(
                                              'assets/images/o.png',
                                              'o',
                                              isPressed,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
        ],
      ),
      // bottomNavigationBar: ,
    );
  }

  void _showSalesLinkLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => SalesLinkLoaderDialog(
            shareContent: _savedText,
            fallbackText: 'Default share text if needed',
          ),
    );
  }

  Widget socialShare(String img, String platform, bool isPressed) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPressed = true;
        });
        _showSalesLinkLoader(context);
        setState(() {
          isPressed = false;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Image.asset(img, width: 25, height: 25),
      ),
    );
  }
}
