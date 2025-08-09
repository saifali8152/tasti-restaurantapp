import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/presentation/bloc/booking_time_state.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/presentation/widgets/activate_tile.dart';
import '../../../../core/widgets/header_cell.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '../../../../config/constants/colors.dart';

class TimeSlotManagementScreen extends StatefulWidget {
  const TimeSlotManagementScreen({super.key});

  @override
  State<TimeSlotManagementScreen> createState() =>
      _TimeSlotManagementScreenState();
}

class _TimeSlotManagementScreenState extends State<TimeSlotManagementScreen> {
  final BookingTimeBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Time Slots Management '),
      body: BlocConsumer<BookingTimeBloc, BookingTimeState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.deactivateResponse.status == Status.error) {
            return context.flushBarErrorMessage(message: state.deactivateResponse.message.toString());
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Active slots:',
                        style: TextStyle(),
                      ),
                      Text(
                        state.fetchResponse.data?.active.length.toString() ??
                            '0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.inactiveTimeSlots);
                        },
                        text:
                            "Inactive Slots: ${state.fetchResponse.data?.inActive.length ?? 0}",
                        isFullWidth: false,
                        borderColor: AppColors.darkOrange,
                        textColor: AppColors.darkOrange,
                        bgColor: Colors.white,
                      )
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
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
                      itemCount: state.fetchResponse.data?.active.length ?? 0,
                      itemBuilder: (_, i) {
                        return ActivateTile(
                          data: state.fetchResponse.data!.active[i],
                          bloc: bloc,
                          id: id,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
