import 'package:flutter/material.dart';
import '/core/widgets/custom_button.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: false,
            floating: true,
            backgroundColor: AppColors.darkOrange,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    const Text(
                      'Manage Booking Time',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
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
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonWithIcon(
                      icon: Icon(Icons.update, size: 20, color: Colors.white),
                      title: 'Update Time Duration',
                      onTap: () {},
                      bgColor: updateBtnColor,
                    ),
                    SizedBox(height: 5),
                    ButtonWithIcon(
                      icon: Icon(Icons.access_alarm,
                          size: 20, color: Colors.white),
                      title: 'Open and Close Time Slots',
                      onTap: () {},
                      bgColor: openBtnColor,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Header
                          Container(
                            height: 48,
                            padding: EdgeInsets.only(
                              top: 5,
                              right: 30,
                              bottom: 5,
                              left: 10,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0XFFF4C4B1),
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ),
                            child: Row(
                              children: const [
                                _HeaderCell('Hours', flex: 0),
                                _HeaderCell('Status'),
                                _HeaderCell('Active', flex: 0),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                              itemCount: _slots.length,
                              itemBuilder: (_, i) {
                                final slot = _slots[i];
                                final color =
                                    slot.isActive ? workingColor : stoppedColor;
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  padding: EdgeInsets.only(
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
                                              fontWeight: FontWeight.bold),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {},
                      text: "Next",
                      isFullWidth: false,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  const _HeaderCell(this.label, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
