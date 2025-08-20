import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '/features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_event.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_state.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_dropdown.dart';

class UpdateTimeDurationScreen extends StatefulWidget {
  const UpdateTimeDurationScreen({super.key});

  @override
  State<UpdateTimeDurationScreen> createState() =>
      _UpdateTimeDurationScreenState();
}

class _UpdateTimeDurationScreenState extends State<UpdateTimeDurationScreen> {
  final BookingTimeBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  String timeDuration = SessionController()
      .user
      ?.restaurant
      .timeDuration; // store selected duration

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Update Time Duration"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Time Duration"),
            const SizedBox(height: 10),
            CustomDropdown(
              initialValue: timeDuration,
              items: const [
                DropdownMenuEntry(value: '+30 minutes', label: '30 minutes'),
                DropdownMenuEntry(value: '+1 hour', label: '1 hour'),
                DropdownMenuEntry(
                    value: '+1 hour 30 minutes', label: '1 hour 30 minutes'),
                DropdownMenuEntry(value: '+2 hours', label: '2 hours'),
                DropdownMenuEntry(
                    value: '+2 hours 30 minutes', label: '2 hours 30 minutes'),
                DropdownMenuEntry(value: '+3 hours', label: '3 hours'),
                DropdownMenuEntry(
                    value: '+3 hours 30 minutes', label: '3 hours 30 minutes'),
                DropdownMenuEntry(value: '+4 hours', label: '4 hours'),
              ],
              onChanged: (val) {
                setState(() {
                  timeDuration = val;
                });
              },
              hintText: 'Select',
            ),
            const SizedBox(height: 20),
            BlocConsumer<BookingTimeBloc, BookingTimeState>(
              bloc: bloc,
              listener: (context, state) {
                if (state.updateDurationResponse.status == Status.error) {
                  context.flushBarErrorMessage(
                    message: state.updateDurationResponse.message.toString(),
                  );
                }
                if (state.updateDurationResponse.status == Status.completed) {
                  context.read<UserCubit>().setUser(SessionController().user!);
                  context.flushBarSuccessMessage(
                    message: state.updateDurationResponse.data.toString(),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  isLoading:
                      state.updateDurationResponse.status == Status.loading,
                  onPressed: () {
                    bloc.add(
                      UpdateDurationTimeEvent(
                        UpdateDurationParms(
                          id: id,
                          timeDuration: timeDuration,
                        ),
                      ),
                    );
                  },
                  text: "Update Duration",
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
