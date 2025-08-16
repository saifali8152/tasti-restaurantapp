import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/reservations/presentation/bloc/reservation_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations/presentation/bloc/reservation_event.dart';
import 'package:tasti_restaurant_app/features/reservations/presentation/bloc/reservation_state.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../config/constants/icons.dart';
import '../../../../config/routes/route_name.dart';
import '../../../../core/widgets/icon_button.dart';
import '../widgets/date_picker.dart';
import '../widgets/revervation_card.dart';
import '/config/constants/colors.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  final ReservationBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;
  String date = '';

  @override
  void initState() {
    super.initState();
    bloc.add(FetchReservationEvent(
        FetchReservationParms(id: id.toString(), date: date)));
  }

  Widget _messageList(String message, {Color? color}) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 16, color: color ?? Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 150,
        title: "Reservation",
        subTitle: ButtonWithIcon(
          icon: Image.asset(AppIcons.reservation,
              color: Colors.white, height: 15),
          title: 'Make reservation',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.makeReservation);
          },
          bgColor: const Color(0xFF02966B),
        ),
      ),
      body: BlocBuilder<ReservationBloc, ReservationState>(
        bloc: bloc,
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(
                FetchReservationEvent(
                  FetchReservationParms(
                    id: id.toString(),
                    date: date,
                  ),
                ),
              );
            },
            child: CurvedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.bookmark, color: Colors.deepOrange),
                            SizedBox(width: 8),
                            Text(
                              'Total Bookings: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.fetchResponse.data?.stats.totalBookings.toString() ?? '0',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.people, color: AppColors.darkOrange),
                            SizedBox(width: 8),
                            Text(
                              'Total Pax: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.fetchResponse.data?.stats.totalPax.toString()??'0',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  ReservationsDatePicker(
                    onDateChanged: (value) {
                      date = value;
                      bloc.add(FetchReservationEvent(FetchReservationParms(id: id.toString(),date:date)));
                    },
                  ),
                  const SizedBox(height: 20),

                  // State-based list
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (state.fetchResponse.status == Status.loading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (state.fetchResponse.status == Status.error) {
                          return _messageList(
                            state.fetchResponse.message.toString(),
                            color: Colors.red,
                          );
                        }

                        if (state.fetchResponse.status == Status.completed) {
                          final reservations = state.fetchResponse.data;
                          if (reservations == null || reservations.data.isEmpty) {
                            return _messageList("No reservations found.");
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            itemCount: reservations.data.length,
                            itemBuilder: (_, index) => RevervationCard(reservation: reservations.data[index], restaurantId: id),
                          );
                        }

                        return _messageList("Something went wrong.");
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
