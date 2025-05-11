import 'package:flutter/material.dart';
import '../../config/constants/spaces.dart';

class CustomDropdown extends StatelessWidget {
  final List<DropdownMenuEntry<String>> items;
  final String hintText;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 0.4;

    return DropdownMenu<String>(
      menuHeight: maxHeight,
      hintText: hintText,
      width: double.infinity,
      dropdownMenuEntries: items,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
            horizontal: AppSpaces.screenHpad, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
      onSelected: (value) {
        if (value != null) onChanged(value);
      },
    );
  }
}
