import 'package:flutter/material.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/header_cell.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../config/constants/colors.dart';
import '../../core/widgets/icon_button.dart';

class TimeSlot {
  final String time;
  final bool isActive;
  String get status => isActive ? 'Working' : 'Stopped';
  TimeSlot({required this.time, required this.isActive});
}

class ManageBookingTimeScreen extends StatelessWidget {
  const ManageBookingTimeScreen({super.key});

  // Generate 48 half-hour slots, with only the first one “stopped”
  List<TimeSlot> get _slots => List.generate(48, (i) {
        final h = (i ~/ 2).toString().padLeft(2, '0');
        final m = i.isEven ? '00' : '30';
        return TimeSlot(time: '$h:$m', isActive: i != 0);
      });

  @override
  Widget build(BuildContext context) {
    const updateBtnColor = Color(0xFF2CB1BA);
    const openBtnColor = Color(0xFF3F51B5);
    const stoppedColor = Color(0xFFE74C3C);
    const workingColor = Color(0xFF27AE60);

    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        title: 'Manage Booking Time',
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reservation Time slot:',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              '1 Hour',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: CurvedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonWithIcon(
              icon: Icon(Icons.update, size: 20, color: Colors.white),
              title: 'Update Time Duration',
              onTap: () {
                Navigator.pushNamed(context, RoutesName.updateTimeDuration);
              },
              bgColor: updateBtnColor,
            ),
            const SizedBox(height: 5),
            ButtonWithIcon(
              icon: Icon(Icons.access_alarm, size: 20, color: Colors.white),
              title: 'Open and Close Time Slots',
              onTap: () {
                Navigator.pushNamed(context, RoutesName.timeSlotManagement);
              },
              bgColor: openBtnColor,
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
                  HeaderCell('Hours'),
                  HeaderCell('Status'),
                  HeaderCell('Active'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _slots.length,
                itemBuilder: (_, i) {
                  final slot = _slots[i];
                  final color = slot.isActive ? workingColor : stoppedColor;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.only(
                      top: 5,
                      right: 30,
                      bottom: 5,
                      left: 10,
                    ),
                    color: Colors.white,
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
                        Expanded(
                          child: Center(
                            child: Text(
                              slot.status,
                              style: TextStyle(
                                fontSize: 12,
                                color: color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              slot.isActive
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              size: 16,
                              color: color,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              slot.isActive ? 'ON' : 'OFF',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: color,
                              ),
                            )
                          ],
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
    );
  }
}


