import 'package:flutter/material.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function()? onCameraTap;
  final Function()? onGalleryTap;
  const ImagePickerDialog({super.key, this.onCameraTap, this.onGalleryTap});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: AlignmentDirectional.center,
      actions: <Widget>[
        const SizedBox(height: 10),
        ListTile(
          onTap: () {
            onCameraTap!();
            Navigator.pop(context);
          },
          leading: const Icon(Icons.camera_alt),
          title: const Text("Take a Photo"),
        ),
        ListTile(
          onTap: () {
            onGalleryTap!();
            Navigator.pop(context);
          },
          leading: const Icon(Icons.image_outlined),
          title: const Text("Choose from Gallery"),
        ),
      ],
    );
  }
}
