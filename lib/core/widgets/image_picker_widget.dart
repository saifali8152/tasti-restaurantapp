import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/utils/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final ValueChanged<File> onImagePicked;
  final String placeholderText;

  const ImagePickerField({
    super.key,
    required this.onImagePicked,
    this.placeholderText = "Tap to pick image",
  });

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  File? _imageFile;

  Future<void> _handlePickImage(BuildContext context) async {
    final image = await ImagePickerHelper.pickImage(context);
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
      widget.onImagePicked(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handlePickImage(context),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: _imageFile == null
            ? Center(child: Text(widget.placeholderText))
            : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _imageFile!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
