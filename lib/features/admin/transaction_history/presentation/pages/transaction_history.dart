import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/presentation/bloc/transaction_history_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/presentation/bloc/transaction_history_event.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/presentation/bloc/transaction_history_state.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/presentation/widgets/transaction_history_card.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  final bloc = sl<FetchTransactionHistoryBloc>();
  @override
  void initState() {
    bloc.add(FetchInitialTransactionHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Transaction History"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: RefreshIndicator(
          onRefresh: ()async{
            bloc.add(FetchInitialTransactionHistory());
          },
          child: BlocBuilder<FetchTransactionHistoryBloc, TransactionHistoryState>(
            bloc: bloc,
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  if (state is FetchTransactionHistoryLoading) {
                    return const Center(child: LoadingWidget());
                  }
              
                  if (state is FetchTransactionHistoryError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  }
              
                  if (state is FetchTransactionHistoryLoaded) {
                    if (state.data.isEmpty) {
                      return Center(
                        child: Text(
                          "No SMS Bundle Found.",
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      );
                    }
              
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!state.isLoadingMore &&
                            state.pagination.hasNext &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 100) {
                          bloc.add(FetchMoreTransactionHistory());
                        }
                        return false;
                      },
                      child: ListView.separated(
                        itemCount:
                            state.data.length + (state.isLoadingMore ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          if (index < state.data.length) {
                            final smsItem = state.data[index];
                            return TransactionHistoryCard(item: smsItem);
                          } else {
                            return const Center(child: LoadingWidget());
                          }
                        },
                      ),
                    );
                  }
              
                  return const Center(child: Text("Something went wrong."));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
