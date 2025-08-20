import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_event.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_state.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/widgets/booking_time_tile.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/header_cell.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../../config/constants/colors.dart';
import '../../../../../core/widgets/icon_button.dart';

class ManageBookingTimeScreen extends StatefulWidget {
  const ManageBookingTimeScreen({super.key});

  @override
  State<ManageBookingTimeScreen> createState() =>
      _ManageBookingTimeScreenState();
}

class _ManageBookingTimeScreenState extends State<ManageBookingTimeScreen> {
  final BookingTimeBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchBookingTimeEvent(id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    const updateBtnColor = Color(0xFF2CB1BA);
    const openBtnColor = Color(0xFF3F51B5);

    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        title: 'Manage Booking Time',
        subTitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reservation Time slot: ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            BlocBuilder<UserCubit, UserCubitState>(
              builder: (context, state) {
                return Text(
                  state.user?.restaurant.timeDuration ?? '0',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<BookingTimeBloc, BookingTimeState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.fetchResponse.status == Status.loading) {
              return Center(child: LoadingWidget());
            }
            if (state.fetchResponse.status == Status.completed &&
                state.fetchResponse.data == null) {
              return Center(child: Text("Nothing Found!"));
            }
            if (state.fetchResponse.status == Status.error) {
              return Center(child: Text(state.fetchResponse.message ?? ''));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonWithIcon(
                  icon: Icon(Icons.update, size: 20, color: Colors.white),
                  title: 'Update Time Duration',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.updateTimeDuration);
                  },
                  bgColor: updateBtnColor,
                ),
                const SizedBox(height: 5),
                ButtonWithIcon(
                  icon: Icon(Icons.access_alarm, size: 20, color: Colors.white),
                  title: 'Open and Close Time Slots',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.timeSlotManagement);
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    itemCount: state.fetchResponse.data?.data.length ?? 0,
                    itemBuilder: (_, i) {
                      return BookingTimeTile(
                          data: state.fetchResponse.data!.data[i]);
                    },
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
