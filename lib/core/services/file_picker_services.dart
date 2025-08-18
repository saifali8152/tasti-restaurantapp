import 'package:file_picker/file_picker.dart';

class FilePickerService {
  /// Pick a single file (all types)
  Future<PlatformFile?> pickFile({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      type: allowedExtensions != null
          ? FileType.custom
          : FileType.any,
      allowedExtensions: allowedExtensions,
    );
    return result?.files.single;
  }

  /// Pick multiple files
  Future<List<PlatformFile>> pickMultipleFiles({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: allowedExtensions != null
          ? FileType.custom
          : FileType.any,
      allowedExtensions: allowedExtensions,
    );
    return result?.files ?? [];
  }

  /// Pick only Excel files (.xlsx, .xls)
  Future<PlatformFile?> pickExcelFile() async {
    return await pickFile(allowedExtensions: ['xlsx', 'xls']);
  }

  /// Pick only images
  Future<PlatformFile?> pickImageFile() async {
    return await pickFile(allowedExtensions: ['jpg', 'jpeg', 'png', 'gif']);
  }

  /// Pick only PDFs
  Future<PlatformFile?> pickPdfFile() async {
    return await pickFile(allowedExtensions: ['pdf']);
  }
}
