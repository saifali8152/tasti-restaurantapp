import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CsvDownloadButton extends StatelessWidget {
  const CsvDownloadButton({super.key});

  Future<void> _generateAndSaveCsv(BuildContext context) async {
    // Request storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    // Example CSV data (template with headers)
    List<List<dynamic>> rows = [
      ['Name', 'Email', 'Phone', 'City', 'Province', 'Country'], // headers
      ["", "", "", "", "", ""], // empty row for user input
    ];

    String csvData = const ListToCsvConverter().convert(rows);

    // Get base directory (Downloads on Android, docs on iOS)
    Directory baseDir;
    if (Platform.isAndroid) {
      baseDir = Directory("/storage/emulated/0/Download");
    } else {
      baseDir = await getApplicationDocumentsDirectory();
    }

    // Create folder `Tasti-CSV-Template`
    Directory targetDir = Directory("${baseDir.path}/Tasti-CSV-Template");
    if (!(await targetDir.exists())) {
      await targetDir.create(recursive: true);
    }

    // File path
    String filePath = "${targetDir.path}/template.csv";
    File file = File(filePath);

    // Save file
    await file.writeAsString(csvData);

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("CSV saved at ${targetDir.path}")),
    );

    debugPrint("✅ CSV saved at $filePath");
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _generateAndSaveCsv(context),
      child: const Text("Download CSV Template"),
    );
  }
}
