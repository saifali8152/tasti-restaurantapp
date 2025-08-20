import 'package:flutter/material.dart';
import '/features/restaurant-admin/manage_booking_time/domain/entities/booking_time.dart';

class BookingTimeTile extends StatelessWidget {
  final BookingTimeDataEntity data;

  const BookingTimeTile({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    const stoppedColor = Color(0xFFE74C3C);
    const workingColor = Color(0xFF27AE60);
    final color = data.isActive ? workingColor : stoppedColor;

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
              data.time,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                data.isActive? "Working" : "Stopped",
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
                data.isActive ? Icons.check_circle : Icons.cancel,
                size: 16,
                color: color,
              ),
              const SizedBox(width: 6),
              Text(
                data.isActive ? 'ON' : 'OFF',
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
  }
}
