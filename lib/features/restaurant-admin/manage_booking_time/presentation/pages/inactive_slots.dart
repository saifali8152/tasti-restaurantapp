import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/widgets/activate_tile.dart';
import '../../../../../core/widgets/header_cell.dart';
import '/core/widgets/custom_app_bar.dart';
import '../../../../../config/constants/colors.dart';

class InactiveSlotsScreen extends StatefulWidget {
  const InactiveSlotsScreen({super.key});

  @override
  State<InactiveSlotsScreen> createState() =>
      _InactiveSlotsScreenState();
}

class _InactiveSlotsScreenState extends State<InactiveSlotsScreen> {
  final BookingTimeBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Inactive Slots'),
      body: BlocConsumer<BookingTimeBloc, BookingTimeState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.activateResponse.status == Status.error) {
            return context.flushBarErrorMessage(message: state.activateResponse.message.toString());
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
                  state.fetchResponse.data!.inActive.isEmpty? Text("Nothing Found!"):
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.fetchResponse.data?.inActive.length ?? 0,
                      itemBuilder: (_, i) {
                        return ActivateTile(
                          data: state.fetchResponse.data!.inActive[i],
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
