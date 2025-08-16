import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/core/utils/general_extentions.dart';
import '../../../../config/constants/colors.dart';
import '../../../../config/constants/icons.dart';

class ReservationsDatePicker extends StatefulWidget {
  final void Function(String formattedDate)? onDateChanged;

  const ReservationsDatePicker({super.key, this.onDateChanged});

  @override
  State<ReservationsDatePicker> createState() => _ReservationsDatePickerState();
}

class _ReservationsDatePickerState extends State<ReservationsDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Emit today’s date when the widget first builds
    final formatted = DateFormat('yyyy-MM-dd').format(selectedDate);
    if (widget.onDateChanged != null) {
      widget.onDateChanged!(formatted);
    }
  }

  void _updateDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });

    final formatted = DateFormat('yyyy-MM-dd').format(newDate);
    if (widget.onDateChanged != null) {
      widget.onDateChanged!(formatted);
    }
  }

  void _goToPreviousDate() {
    _updateDate(selectedDate.subtract(const Duration(days: 1)));
  }

  void _goToNextDate() {
    _updateDate(selectedDate.add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: RotatedBox(
            quarterTurns: 2,
            child: Image.asset(
              AppIcons.arrowForward,
              height: 20,
              color: Colors.deepOrange,
            ),
          ),
          onPressed: _goToPreviousDate,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.darkOrange),
          ),
          child: Row(
            children: [
              Text(
                // Pretty UI format
                DateFormat('dd/MM/yyyy').format(selectedDate),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  context.showCustomDatePicker(
                    initialDate: selectedDate,
                    onDateSelected: (picked) {
                      _updateDate(picked);
                    },
                  );
                },
                child: const Icon(Icons.calendar_today_outlined, size: 16),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Image.asset(
            AppIcons.arrowForward,
            height: 20,
            color: Colors.deepOrange,
          ),
          onPressed: _goToNextDate,
        ),
      ],
    );
  }
}
