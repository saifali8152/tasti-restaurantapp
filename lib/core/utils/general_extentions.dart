import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormattedDateExtension on DateTime? {
  String formatDate({String pattern = 'yyyy-MM-dd'}) {
    final date = this ?? DateTime.now();
    return DateFormat(pattern).format(date);
  }
}

extension FormattedMonthYear on DateTime {
  String get monthYear {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${monthNames[month - 1]} $year';
  }
}

extension ShowDialogExtension on BuildContext {
  void showCustomDialog(Widget widget, {bool isDismissible = true}) {
    showDialog(
      context: this,
      barrierColor: Colors.black87,
      barrierDismissible: isDismissible,
      builder: (context) => widget,
    );
  }
}

extension DatePickerExtension on BuildContext {
  Future<void> showCustomDatePicker({
    required DateTime initialDate,
    required Function(DateTime) onDateSelected,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: this,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepOrange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepOrange,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }
}

extension ContextExtensions on BuildContext {
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
    bool isDismissible = true,
    bool enableDrag = true,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      elevation: elevation,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
      builder: (context) => child,
    );
  }
}

extension SafeOpacity on Color {
  Color withSafeOpacity(double opacity) => withAlpha((opacity * 255).round());
}
