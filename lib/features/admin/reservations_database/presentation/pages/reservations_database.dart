import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/features/admin/reservations_database/presentation/bloc/admin_reservation_bloc.dart';
import '/features/admin/reservations_database/presentation/bloc/admin_reservation_event.dart';
import '/features/admin/reservations_database/presentation/bloc/admin_reservation_state.dart';
import '/core/widgets/custom_input_field.dart';
import '../widgets/reservation_db_card.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class ReservationsDatabase extends StatefulWidget {
  const ReservationsDatabase({super.key});

  @override
  State<ReservationsDatabase> createState() => _ReservationsDatabaseState();
}

class _ReservationsDatabaseState extends State<ReservationsDatabase> {
  final bloc = sl<AdminReservationBloc>();
  @override
  void initState() {
    bloc.add(FetchInitialAdminReservation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Reservations Database",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomInputField(
            icon: Icons.search,
            hintText: "Search",
            onChanged: (p0) => bloc.add(SearchAdminReservation(p0)),
          ),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<AdminReservationBloc, AdminReservationState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is AdminReservationLoading) {
              return const Center(child: LoadingWidget());
            }

            if (state is AdminReservationError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (state is AdminReservationLoaded) {
              if (state.data.isEmpty) {
                return Center(
                  child: Text(
                    "No Reservations Found.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!state.isLoadingMore &&
                      state.pagination.hasNext &&
                      scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 100) {
                    bloc.add(FetchMoreAdminReservation());
                  }

                  return false;
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: state.data.length + (state.isLoadingMore ? 1 : 0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (index < state.data.length) {
                      return ReservationsDBCard(item: state.data[index]);
                    } else {
                      return const Center(child: LoadingWidget());
                    }
                  },
                ),
              );
            }

            // Default fallback (initial state or unknown state)
            return const Center(child: Text("Something went wrong."));
          },
        ),
      ),
    );
  }
}
