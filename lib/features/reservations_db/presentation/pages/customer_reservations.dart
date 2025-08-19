import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/curved_container.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/core/widgets/themed_app_bar.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_event.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/bloc/customer_reservations/customer_reservations_state.dart';
import 'package:tasti_restaurant_app/features/reservations_db/presentation/widgets/customer_reservation_card.dart';

class CustomerReservations extends StatefulWidget {
  const CustomerReservations({super.key});

  @override
  State<CustomerReservations> createState() => _CustomerReservationsState();
}

class _CustomerReservationsState extends State<CustomerReservations> {
  final CustomerReservationsBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchReservationEvent(id.toString()));
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
        height: 100,
        title: "Customer Reservations",
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'csv':
                  Navigator.pushNamed(context, AppRoutes.csvImportedData);
                  break;
                case 'sms':
                  // handle SMS/Email Customers
                  break;
                case 'targeted':
                  Navigator.pushNamed(context, AppRoutes.targetedCampaign);
                  break;
                case 'view_campaigns':
                  Navigator.pushNamed(context, AppRoutes.campaigns);
                  break;
                case 'import':
                  Navigator.pushNamed(context, AppRoutes.importDatabase);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'csv',
                child: Text('CSV Imported Data'),
              ),
              const PopupMenuItem(
                value: 'sms',
                child: Text('SMS/Email Customers'),
              ),
              const PopupMenuItem(
                value: 'targeted',
                child: Text('Targeted Campaign'),
              ),
              const PopupMenuItem(
                value: 'view_campaigns',
                child: Text('View Campaigns'),
              ),
              const PopupMenuItem(
                value: 'import',
                child: Text('Import Database'),
              ),
            ],
          ),
        ],
      ),
      body: CurvedContainer(
        child: BlocBuilder<CustomerReservationsBloc, CustomerReservationsState>(
          bloc: bloc,
          builder: (context, state) {
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                bloc.add(FetchReservationEvent(id.toString()));
              },
              child: Builder(
                builder: (context) {
                  if (state.fetchRevervationResponse.status == Status.loading) {
                    return const Center(child: LoadingWidget());
                  }
                      
                  if (state.fetchRevervationResponse.status == Status.error) {
                    return _messageList(
                      state.fetchRevervationResponse.message.toString(),
                      color: Colors.red,
                    );
                  }
                      
                  if (state.fetchRevervationResponse.status == Status.completed) {
                    final data = state.fetchRevervationResponse.data ?? [];
                    if (data.isEmpty) {
                      return _messageList("Nothing Found.");
                    }
                      
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final reservation = data[index];
                        return CustomerReservationCard(data: reservation);
                      },
                    );
                  }
                      
                  return _messageList("Something went wrong.");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
