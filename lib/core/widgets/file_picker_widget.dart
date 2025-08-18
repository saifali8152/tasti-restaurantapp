import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/services/file_picker_services.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/core/widgets/icon_button.dart';

class FilePickerWidget extends StatefulWidget {
  final void Function(PlatformFile file)? onFileSelected;
  final List<String>? allowedExtensions;

  const FilePickerWidget({
    super.key,
    this.onFileSelected,
    this.allowedExtensions,
  });

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  PlatformFile? selectedFile;
  final FilePickerService _filePickerService = FilePickerService();

  Future<void> _pickFile() async {
    final file = await _filePickerService.pickFile(
        allowedExtensions: widget.allowedExtensions);
    if (file != null) {
      setState(() {
        selectedFile = file;
      });
      widget.onFileSelected?.call(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: selectedFile == null ? Colors.grey.shade200 : AppColors.darkOrange.withSafeOpacity(.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                selectedFile == null ? Icons.upload_file_outlined : Icons.check,
                color: selectedFile == null ? Colors.grey : AppColors.darkOrange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                selectedFile?.name ?? 'Select a file',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedFile == null ? Colors.grey.shade600 : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ButtonWithIcon(
              onTap: _pickFile,
              icon: const Icon(Icons.folder_open, color: Colors.white),
              title: 'Browse',
            ),
          ],
        ),
      ),
    );
  }
}
