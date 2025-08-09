import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/presentation/pages/pdf_preview.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final String menu; // assuming this is your PDF URL or path

  const MenuButton({
    super.key,
    required this.text,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
      icon: Icon(Icons.menu_book, size: 20, color: AppColors.darkOrange),
      label: Text(
        text,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkOrange),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewerPage(pdfUrl: menu, title: text),
          ),
        );
      },
    );
  }
}
