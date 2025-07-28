import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/common/manage_fee/presentation/widgets/admin_content.dart';
import 'package:tasti_restaurant_app/features/common/manage_fee/presentation/widgets/feature_item.dart';
import 'package:tasti_restaurant_app/features/common/manage_fee/presentation/widgets/subscribe_dialog.dart';
import '/config/constants/colors.dart';
import '/core/network/response.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '../bloc/get_monthly_fee_bloc.dart';
import '../bloc/get_monthly_fee_event.dart';
import '../bloc/get_monthly_fee_state.dart';

class MonthlyFee extends StatefulWidget {
  const MonthlyFee({super.key});

  @override
  State<MonthlyFee> createState() => _MonthlyFeeState();
}

class _MonthlyFeeState extends State<MonthlyFee> {
  final bloc = sl<AdminMonthlyFeeBloc>();
  @override
  void initState() {
    bloc.add(FetchMonthlyFeeSubmitted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: SessionController().user?.type == "admin"
            ? 'Manage Monthly Fee'
            : 'Monthly Fee',
        applyLeading: SessionController().user?.type == "admin",
      ),
      body: BlocBuilder<AdminMonthlyFeeBloc, MonthlyFeeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.fetchResponse.status == Status.loading) {
            return const Center(child: LoadingWidget());
          }

          if (state.fetchResponse.status == Status.error) {
            return Center(
              child: Text(
                state.fetchResponse.message.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          if (state.fetchResponse.status == Status.completed) {
            if (state.fetchResponse.data == null) {
              return Center(
                child: Text(
                  "No Montly Fee Found.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if (SessionController().user?.type == 'restaurant')
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              decoration: BoxDecoration(
                                color: AppColors.darkOrange,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Text(
                                'Tasti Restaurant Monthly Subscription',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Column(
                              children: [
                                Text(
                                  state.fetchResponse.data?.money ?? "N/A",
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const Text(
                                  'per month',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            FeatureItem(
                                text:
                                    'Full access to reservation management system'),
                            FeatureItem(
                                text:
                                    'Table booking and availability tracking'),
                            FeatureItem(
                                text: 'Reservation scheduling and reminders'),
                            FeatureItem(text: 'Guest management and history'),
                            FeatureItem(text: '24/7 Support'),
                            const SizedBox(height: 32),
                            CustomButton(
                              onPressed: () {
                                context.showCustomDialog(SubscribeDialog(amount: state.fetchResponse.data?.money??'0'));
                              },
                              text: 'Subscribe Now',
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20),
                    if (SessionController().user?.type == 'admin') ...[
                      AdminContent(item: state.fetchResponse.data!)
                    ],
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text("Something went wrong."));
        },
      ),
    );
  }
}
