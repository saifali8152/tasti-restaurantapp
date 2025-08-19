import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/presentation/bloc/reservation_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/presentation/bloc/reservation_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations/presentation/bloc/reservation_state.dart';

class AddUpdateWaiterDialog extends StatelessWidget {
  final String waiter;
  final int reservationId;
  final int restaurantId;

  const AddUpdateWaiterDialog({
    super.key,
    required this.waiter,
    required this.reservationId,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: waiter);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<ReservationBloc, ReservationState>(
          bloc: context.read<ReservationBloc>(),
          listener: (context, state) {
            if (state.addUpdateWaiter.status == Status.error) {
              context.flushBarErrorMessage(
                message: state.addUpdateWaiter.message.toString(),
              );
            }
            if (state.addUpdateWaiter.status == Status.completed) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  waiter.isEmpty ? "Add Waiter" : "Update Waiter",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                /// Input Field
                CustomInputField(
                  controller: controller,
                  hintText: "Enter waiter name",
                ),
                const SizedBox(height: 24),

                /// Full Width Button
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    isLoading: state.addUpdateWaiter.status == Status.loading,
                    onPressed: () {
                      context.read<ReservationBloc>().add(
                            AddUpdateWaiter(
                              AddUpdateWaiterParms(
                                reservationId: reservationId,
                                restaurantId: restaurantId,
                                waiterName: controller.text.trim(),
                              ),
                            ),
                          );
                    },
                    text: waiter.isEmpty ? "Add" : "Update",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}