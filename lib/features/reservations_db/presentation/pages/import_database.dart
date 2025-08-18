import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/widgets/csv_download_button.dart';
import '/core/widgets/custom_app_bar.dart';

class ImportDatabase extends StatelessWidget {
  const ImportDatabase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Import Database'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CsvDownloadButton(),
          ],
        ),
      ),
    );
  }
}
