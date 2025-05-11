import 'package:flutter/material.dart';
import '../../core/widgets/header_cell.dart';
import '/core/utils/general_extentions.dart';
import '/core/widgets/custom_app_bar.dart';
import '../../config/constants/colors.dart';

class TimeSlotss {
  final String time;
  final bool isActive;
  TimeSlotss({required this.time, required this.isActive});
}

class InactiveSlotsScreen extends StatelessWidget {
  const InactiveSlotsScreen({super.key});

  // Generate 48 half-hour slots, with only the first one “stopped”
  List<TimeSlotss> get _slots => List.generate(48, (i) {
        final h = (i ~/ 2).toString().padLeft(2, '0');
        final m = i.isEven ? '00' : '30';
        return TimeSlotss(time: '$h:$m', isActive: i != 0);
      });

  @override
  Widget build(BuildContext context) {
    const stoppedColor = Color(0xFFE74C3C);
    const workingColor = Color(0xFF27AE60);

    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: CustomAppBar(title: 'Inactive Time Slots'),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    'InActive slots:',
                    style: TextStyle(
                    ),
                  ),
                  Text(
                    '41',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 48,
                padding: const EdgeInsets.only(
                  top: 5,
                  right: 30,
                  bottom: 5,
                  left: 10,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.tileHeader,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  children: const [
                    HeaderCell('Time Slot'),
                    Spacer(),
                    HeaderCell('Status'),
                    Spacer(),
                    HeaderCell('Actions'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _slots.length,
                  itemBuilder: (_, i) {
                    final slot = _slots[i];
                    // final color = slot.isActive ? workingColor : stoppedColor;
                    final color = stoppedColor;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.only(
                        top: 5,
                        right: 10,
                        bottom: 5,
                        left: 10,
                      ),
                      color: AppColors.background,
                      child: Row(
                        children: [
                          Center(
                            child: Text(
                              slot.time,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 70,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: color.withSafeOpacity(.2),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text(
                                "OFF",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),

                          Container(
                            width: 70,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: workingColor,
                              // color: slot.isActive? color.withSafeOpacity(.2) : AppColors.pending,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text(
                                // slot.isActive ? 'Open Time' : 'Deactivate',
                                'Open Time',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  // color: slot.isActive? color : AppColors.white,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}