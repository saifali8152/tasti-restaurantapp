import '/features/admin/events/presentation/bloc/event_event.dart';
import '/features/admin/events/presentation/bloc/event_state.dart';
import '/features/admin/events/presentation/bloc/event_bloc.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DeleteEventDialog extends StatelessWidget {
  final String id;
  const DeleteEventDialog({super.key, required this.id});

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
              'Are you sure you want to delete this query? This action cannot be undone.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            BlocConsumer<EventBloc, EventState>(
              bloc: context.read<EventBloc>(),
              listener: (context, state) {
                if (state.deleteResponse.status == Status.error) {
                  context.flushBarErrorMessage(
                      message: state.deleteResponse.message.toString());
                }
                if (state.deleteResponse.status == Status.completed) {
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
                          context
                              .read<EventBloc>()
                              .add(AdminDeleteEvent(int.parse(id)));
                        },
                        text: "Confirm",
                        isLoading:
                            state.deleteResponse.status == Status.loading,
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
