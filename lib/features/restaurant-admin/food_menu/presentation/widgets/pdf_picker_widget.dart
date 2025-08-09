import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PDFPickerWidget extends StatefulWidget {
  final void Function(String? path) onFilePicked;

  const PDFPickerWidget({super.key, required this.onFilePicked});

  @override
  State<PDFPickerWidget> createState() => _PDFPickerWidgetState();
}

class _PDFPickerWidgetState extends State<PDFPickerWidget> {
  String? _pickedFileName;

  Future<void> _pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path;
      final fileName = result.files.single.name;

      setState(() {
        _pickedFileName = fileName;
      });

      widget.onFilePicked(filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.deepOrange;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _pickPdfFile,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.picture_as_pdf, color: color, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _pickedFileName ?? 'Select PDF file',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_pickedFileName != null)
                Icon(Icons.check_circle, color: Colors.green, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
