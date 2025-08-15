import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/presentation/bloc/bundle_billing_bloc.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/presentation/bloc/bundle_billing_event.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/presentation/bloc/bundle_billing_state.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/presentation/widgets/transaction_card.dart';
import '../../../../../config/constants/icons.dart';
import '../../../../../core/widgets/icon_button.dart';

class RestaurantTransactionHistory extends StatefulWidget {
  const RestaurantTransactionHistory({super.key});

  @override
  State<RestaurantTransactionHistory> createState() =>
      _RestaurantTransactionHistoryState();
}

class _RestaurantTransactionHistoryState
    extends State<RestaurantTransactionHistory> {
  final BundleBillingBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchInitialRestaurantTransactions());
  }

  Widget _buildScrollContent(Widget child) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: child,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Transaction History"),
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
              child: BlocBuilder<BundleBillingBloc, BundleBillingState>(
                bloc: bloc,
                builder: (context, state) {
                  return RefreshIndicator.adaptive(
                    onRefresh: () async {
                      bloc.add(FetchInitialRestaurantTransactions());
                    },
                    child: Builder(
                      builder: (context) {
                        if (state.fetchTransactionHistoryResponse.status ==
                            Status.loading) {
                          return _buildScrollContent(
                            const Center(child: LoadingWidget()),
                          );
                        }
                    
                        if (state.fetchTransactionHistoryResponse.status == Status.error) {
                          return _buildScrollContent(
                            Center(
                              child: Text(
                                state.fetchTransactionHistoryResponse.message.toString(),
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            ),
                          );
                        }
                    
                        if (state.fetchTransactionHistoryResponse.status ==
                            Status.completed) {
                          if (state.fetchTransactionHistoryResponse.data!.isEmpty) {
                            return _buildScrollContent(
                              Center(
                                child: Text(
                                  "Nothing Found.",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                ),
                              ),
                            );
                          }
                    
                          return NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (!state.isTransactionLoadingMore &&
                                  state.transactionPagination!.hasNext &&
                                  scrollInfo.metrics.pixels >=
                                      scrollInfo.metrics.maxScrollExtent -
                                          100) {
                                bloc.add(FetchMoreRestaurantTransactions());
                              }
                              return false;
                            },
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  state.fetchTransactionHistoryResponse.data!.length +
                                      (state.isTransactionLoadingMore ? 1 : 0),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                if (index <
                                    state.fetchTransactionHistoryResponse.data!.length) {
                                  final transactionHistory =
                                      state.fetchTransactionHistoryResponse.data![index];
                                  return TransactionCard(transactionHistory: transactionHistory);
                                } else {
                                  return const Center(child: LoadingWidget());
                                }
                              },
                            ),
                          );
                        }
                    
                        return _buildScrollContent(
                          const Center(child: Text("Something went wrong.")),
                        );
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
