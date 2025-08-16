import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/presentation/widgets/sms_card.dart';

class BuySmsBundle extends StatefulWidget {
  const BuySmsBundle({super.key});

  @override
  State<BuySmsBundle> createState() => _BuySmsBundleState();
}

class _BuySmsBundleState extends State<BuySmsBundle> {
  final BundleBillingBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchSMSBundleBillingEvent());
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
      appBar: CustomAppBar(title: "Buy SMS Bundles"),
      body: BlocBuilder<BundleBillingBloc, BundleBillingState>(
        bloc: bloc,
        builder: (context, state) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              bloc.add(FetchSMSBundleBillingEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Builder(
                builder: (context) {
                  if (state.fetchSMSResponse.status == Status.loading) {
                    return const Center(child: LoadingWidget());
                  }
                    
                  if (state.fetchSMSResponse.status == Status.error) {
                    return _messageList(
                      state.fetchSMSResponse.message.toString(),
                      color: Colors.red,
                    );
                  }
                    
                  if (state.fetchSMSResponse.status == Status.completed) {
                    final data = state.fetchSMSResponse.data ?? [];
                    if (data.isEmpty) {
                      return _messageList("Nothing Found.");
                    }
                    
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final sms = data[index];
                        return SmsCard(sms: sms);
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
