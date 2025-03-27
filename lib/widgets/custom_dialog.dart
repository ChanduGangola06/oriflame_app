import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onClose;
  const CustomDialog({
    super.key,
    required this.onSave,
    required this.controller,
    required this.onClose,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late FocusNode _textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    _textFieldFocusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _textFieldFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose(); // Dispose focus node
    super.dispose();
  }

  void _handleSave() {
    _textFieldFocusNode.unfocus(); // Dismiss keyboard
    widget.onSave();
  }

  void _handleClose() {
    _textFieldFocusNode.unfocus(); // Dismiss keyboard
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _textFieldFocusNode.unfocus();
          },
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Header with close and save buttons
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _handleClose,
                      ),
                      const Text(
                        'Edit Caption',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: _handleSave,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            left: 8,
                            right: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF7EC086),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Text field
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: TextField(
                        controller: widget.controller,
                        focusNode: _textFieldFocusNode,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Add Caption...',
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        ),
                        maxLines: 15,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //   Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             IconButton(
    //               icon: const Icon(Icons.close),
    //               onPressed: () => Navigator.of(context).pop(),
    //             ),
    //             const Text(
    //               'Edit Caption',
    //               style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    //             ),
    //             GestureDetector(
    //               onTap: () {
    //                 widget.onSave(_textController.text);
    //                 Navigator.of(context).pop();
    //               },
    //               child: Container(
    //                 margin: EdgeInsets.only(right: 10),
    //                 padding: EdgeInsets.only(
    //                   top: 4,
    //                   bottom: 4,
    //                   left: 8,
    //                   right: 8,
    //                 ),
    //                 decoration: BoxDecoration(
    //                   color: Color(0xFF7EC086),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Text(
    //                   'Save',
    //                   style: TextStyle(color: Colors.white, fontSize: 14),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         const SizedBox(height: 16),
    //         // Text field
    //         TextField(
    //           controller: _textController,
    //           decoration: const InputDecoration(
    //             border: OutlineInputBorder(),
    //             labelText: 'Enter your text',
    //             hintText: 'Type something...',
    //             contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
    //           ),
    //           maxLines: 15,
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
