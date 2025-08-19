import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_event.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_state.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/widgets/customer_reservation_by_email_card.dart';

class CustomerReservationsByEmail extends StatefulWidget {
  final String email;
  const CustomerReservationsByEmail({super.key, required this.email});

  @override
  State<CustomerReservationsByEmail> createState() => _CustomerReservationsByEmailState();
}

class _CustomerReservationsByEmailState extends State<CustomerReservationsByEmail> {
  final CustomerReservationsBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchReservationDataByEmailEvent(FetchReservationByEmailParms(restaurantId: id, email: widget.email)));
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
      appBar: CustomAppBar(title: "Reservations"),
      body: BlocBuilder<CustomerReservationsBloc, CustomerReservationsState>(
        bloc: bloc,
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(FetchReservationDataByEmailEvent(FetchReservationByEmailParms(restaurantId: id, email: widget.email)));
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  if (state.fetchRevervationByEmailResponse.status == Status.loading) {
                    return const Center(child: LoadingWidget());
                  }
                    
                  if (state.fetchRevervationByEmailResponse.status == Status.error) {
                    return _messageList(
                      state.fetchRevervationByEmailResponse.message.toString(),
                      color: Colors.red,
                    );
                  }
                    
                  if (state.fetchRevervationByEmailResponse.status == Status.completed) {
                    final data = state.fetchRevervationByEmailResponse.data ?? [];
                    if (data.isEmpty) {
                      return _messageList("Nothing Found.");
                    }
                    
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final emailData = data[index];
                        return CustomerReservationByEmailCard(data: emailData);
                      },
                    );
                  }
                    
                  return _messageList("Something went wrong.");
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
