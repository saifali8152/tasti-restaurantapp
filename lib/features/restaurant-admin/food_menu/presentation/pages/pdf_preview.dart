import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerPage({super.key, required this.pdfUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SfPdfViewer.network(pdfUrl),
      // or use SfPdfViewer.file(File(pdfUrl)) if local file
    );
  }
}
