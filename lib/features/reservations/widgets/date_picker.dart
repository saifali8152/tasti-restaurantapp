import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/core/utils/general_extentions.dart';
import '../../../config/constants/colors.dart';
import '../../../config/constants/icons.dart';

class ReservationsDatePicker extends StatefulWidget {
  const ReservationsDatePicker({super.key});

  @override
  State<ReservationsDatePicker> createState() => _ReservationsDatePickerState();
}

class _ReservationsDatePickerState extends State<ReservationsDatePicker> {
  DateTime selectedDate = DateTime.now();

  void _goToPreviousDate() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
  }

  void _goToNextDate() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
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
                      setState(() {
                        selectedDate = picked;
                      });
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
