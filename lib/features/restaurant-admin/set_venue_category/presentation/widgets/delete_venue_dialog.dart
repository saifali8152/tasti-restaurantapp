import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_state.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DeleteVenueDialog extends StatelessWidget {
  final String id;
  const DeleteVenueDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.black),
              ),
            ),
            const Icon(Icons.logout, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Alert',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Are you sure you want to delete these Venues? This action cannot be undone.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            BlocConsumer<VenueBloc, VenueState>(
              bloc: context.read<VenueBloc>(),
              listener: (context, state) {
                if (state.deleteVenues.status == Status.error) {
                  context.flushBarErrorMessage(
                      message: state.deleteVenues.message.toString());
                }
                if (state.deleteVenues.status == Status.completed) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Navigator.pop(context),
                        text: "Cancel",
                        bgColor: Colors.white,
                        textColor: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          context.read<VenueBloc>().add(DeleteVenueEvent(id));
                        },
                        text: "Confirm",
                        isLoading: state.deleteVenues.status == Status.loading,
                        bgColor: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
