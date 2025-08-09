import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/entities/booking_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_event.dart';

class ActivateTile extends StatelessWidget {
  final BookingTimeDataEntity data;
  final BookingTimeBloc bloc;
  final int id;
  const ActivateTile({
    super.key,
    required this.data,
    required this.bloc,
    required this.id,
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
        right: 10,
        bottom: 5,
        left: 10,
      ),
      color: AppColors.background,
      child: Row(
        children: [
          Center(
            child: Text(
              data.time.toString(),
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
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                data.isActive ? "Active" : "Off",
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              bloc.add(
                data.isActive
                    ? DeactivateBookingTimeEvent(
                        ActivateDeactivateTimeParms(
                          id: id,
                          timeId: data.timeId,
                        ),
                      )
                    : ActivateBookingTimeEvent(
                        ActivateDeactivateTimeParms(
                          id: id,
                          timeId: data.timeId,
                        ),
                      ),
              );
            },
            child: Container(
              width: 70,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: data.isActive
                    ? AppColors.pending
                    : color.withSafeOpacity(.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  data.isActive ? 'Deactivate' : 'Activate',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: data.isActive ? AppColors.white : color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
