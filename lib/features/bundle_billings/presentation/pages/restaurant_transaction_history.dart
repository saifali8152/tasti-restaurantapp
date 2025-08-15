import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/presentation/bloc/seating_area_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/presentation/bloc/seating_area_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/seating_area/presentation/bloc/seating_area_state.dart';
import '../../../../../config/constants/icons.dart';
import '../../../../../core/widgets/icon_button.dart';
import '../widgets/billing_card.dart';

class RestaurantTransactionHistory extends StatefulWidget {
  const RestaurantTransactionHistory({super.key});

  @override
  State<RestaurantTransactionHistory> createState() =>
      _RestaurantTransactionHistoryState();
}

class _RestaurantTransactionHistoryState
    extends State<RestaurantTransactionHistory> {
  final SeatingAreaBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchSeatingAreaEvent(id.toString()));
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
      appBar: CustomAppBar(
        title: "SMS Bundles & Transactions",
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ButtonWithIcon(
            icon: Image.asset(AppIcons.seatingArea,
                color: Colors.white, height: 15),
            title: 'Sms History',
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.buySmsBundles);
            },
            bgColor: const Color(0xFF5A73E2),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<SeatingAreaBloc, SeatingAreaState>(
                bloc: bloc,
                builder: (context, state) {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      bloc.add(FetchSeatingAreaEvent(id.toString()));
                    },
                    child: Builder(
                      builder: (context) {
                        if (state.fetchResponse.status == Status.loading) {
                          return const Center(child: LoadingWidget());
                        }
              
                        if (state.fetchResponse.status == Status.error) {
                          return _messageList(
                            state.fetchResponse.message.toString(),
                            color: Colors.red,
                          );
                        }
              
                        if (state.fetchResponse.status == Status.completed) {
                          final data = state.fetchResponse.data ?? [];
                          if (data.isEmpty) {
                            return _messageList("No Seating Area Found.");
                          }
              
                          return ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: data.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              final seatingArea = data[index];
                              return BillingCard(seatingArea: seatingArea);
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
          ),
        ],
      ),
    );
  }
}
