import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import '/config/constants/colors.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import '/features/restaurant-admin/reservations/domain/entities/reservation.dart';
import '/features/restaurant-admin/reservations/presentation/bloc/reservation_bloc.dart';
import '/features/restaurant-admin/reservations/presentation/bloc/reservation_event.dart';
import '/features/restaurant-admin/reservations/presentation/bloc/reservation_state.dart';
import '/core/widgets/details_row.dart';
import '/core/widgets/custom_app_bar.dart';

class ReservationDetails extends StatelessWidget {
  final ReservationItem reservation;
  const ReservationDetails({super.key, required this.reservation});

  String formatStatus(String status) {
    switch (status.toLowerCase()) {
      case "arrived":
        return "Arrived";
      case "no_show":
        return "No Show";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = reservation.statusDisplay.toLowerCase();
    final actionDate = reservation.actionDate;

    Color? bgColor;
    Color? textColor;
    String? displayText;

    if (status == "cancelled") {
      bgColor = Colors.red.withSafeOpacity(0.1);
      textColor = Colors.red;
      displayText = "The reservation is marked as Canceled at $actionDate";
    } else if (status == "arrived") {
      bgColor = Colors.green.withSafeOpacity(0.1);
      textColor = Colors.green;
      displayText = "The reservation is marked as Arrived at $actionDate";
    } else if (status == "no_show") {
      bgColor = Colors.orange.withSafeOpacity(0.1);
      textColor = Colors.orange;
      displayText = "The reservation is marked as No Show at $actionDate";
    } else {
      bgColor = Colors.grey.withSafeOpacity(0.1);
      textColor = Colors.grey;
      displayText = "The reservation status is ${reservation.statusDisplay}";
    }

    return Scaffold(
      appBar: CustomAppBar(title: 'Reservation Details'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ReservationBloc, ReservationState>(
          bloc: context.read<ReservationBloc>(),
          listener: (context, state) {
            if (state.updateResponse.status == Status.error) {
              context.flushBarErrorMessage(
                  message: state.updateResponse.message.toString());
            }
            if (state.cancelResponse.status == Status.error) {
              context.flushBarErrorMessage(
                  message: state.cancelResponse.message.toString());
            }
            if (state.updateConfirmationResponse.status == Status.error) {
              context.flushBarErrorMessage(
                  message: state.updateConfirmationResponse.message.toString());
            }
            if (state.updateConfirmationResponse.status == Status.completed) {
              Navigator.pop(context);
            }
            if (state.cancelResponse.status == Status.completed) {
              Navigator.pop(context);
            }
            if (state.updateResponse.status == Status.completed) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Show banner only if status is Arrived / No Show
                if (displayText != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      displayText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],

                // ✅ Then show details
                DetailsRow(title: 'Guest Name', value: reservation.name),
                DetailsRow(
                    title: 'Party Size', value: reservation.guests.toString()),
                DetailsRow(
                    title: 'Time From', value: reservation.formattedStartTime),
                DetailsRow(
                    title: 'Time To', value: reservation.formattedEndTime),
                DetailsRow(title: 'Seating Area', value: reservation.notes),

                if (reservation.hasSpecialNotes != false) ...[
                  const SizedBox(height: 15),
                  const Text(
                    "Special Request",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  DetailsRow(
                      title: 'Dietary Requirements',
                      value: reservation.dietary),
                  DetailsRow(
                      title: 'Special Occasion', value: reservation.occasion),
                  DetailsRow(
                      title: 'Waiting Preferences', value: reservation.request),
                  const SizedBox(height: 5),
                ],
                Spacer(),

                if (reservation.statusDisplay.toLowerCase() == "pending") ...[
                  if(!reservation.isConfirmed)...[

                  const SizedBox(height: 10),
                  CustomButton(
                      isLoading: state.updateConfirmationResponse.status == Status.loading,
                      onPressed: () {
                        context
                            .read<ReservationBloc>()
                            .add(UpdateReservationConfirmation(reservation.id.toString()));
                      },
                      text: "Confirm Reservation"),
                  ],
                  const SizedBox(height: 10),
                  CustomButton(
                      isLoading: state.cancelResponse.status == Status.loading,
                      onPressed: () {
                        context
                            .read<ReservationBloc>()
                            .add(CancelReservation(reservation.id.toString()));
                      },
                      text: "Cancel Reservation"),
                  const SizedBox(height: 10),
                  CustomButton(
                      isLoading: state.updateResponse.status == Status.loading,
                      onPressed: () {
                        context.read<ReservationBloc>().add(
                            UpdateReservationStatus(
                                UpdateReservationStatusParms(
                                    reservationId: reservation.id,
                                    status: "no")));
                      },
                      text: "Mark as No-Show",
                      bgColor: AppColors.pending),
                  const SizedBox(height: 10),
                  CustomButton(
                      isLoading: state.updateResponse.status == Status.loading,
                      onPressed: () {
                        context.read<ReservationBloc>().add(
                            UpdateReservationStatus(
                                UpdateReservationStatusParms(
                                    reservationId: reservation.id,
                                    status: "yes")));
                      },
                      text: "Mark Arrived",
                      bgColor: Colors.green),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
