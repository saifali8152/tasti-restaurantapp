import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/utils/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final ValueChanged<File> onImagePicked;
  final String placeholderText;
  final String? initialImage; // New: can be file path or network URL

  const ImagePickerField({
    super.key,
    required this.onImagePicked,
    this.placeholderText = "Tap to pick image",
    this.initialImage,
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

  Widget _buildImageWidget() {
    if (_imageFile != null) {
      return Image.file(_imageFile!, width: double.infinity, fit: BoxFit.cover);
    }

    if (widget.initialImage != null && widget.initialImage!.isNotEmpty) {
      // Determine if it's a file path or a network URL
      if (widget.initialImage!.startsWith('http')) {
        return Image.network(widget.initialImage!,
            width: double.infinity, fit: BoxFit.cover);
      } else {
        final file = File(widget.initialImage!);
        if (file.existsSync()) {
          return Image.file(file, width: double.infinity, fit: BoxFit.cover);
        }
      }
    }

    return Center(child: Text(widget.placeholderText));
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _buildImageWidget(),
        ),
      ),
    );
  }
}
