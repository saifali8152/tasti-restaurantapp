import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/enum/subscription_status.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/payment_webview_service.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_event.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_state.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import '/dependency_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SubscribeDialog extends StatelessWidget {
  final String amount;
  const SubscribeDialog({super.key, required this.amount});

  void _handleLoginNavigation(BuildContext context) {
    final user = SessionController().user;
    if (user == null) return;

    if (user.type == 'admin') {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
    } else if (user.type == 'restaurant') {
      final status = user.subscriptionStatus;
      if (status == SubscriptionStatus.active.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.skaleton, (route) => false);
      }
      if (status == SubscriptionStatus.noRestaurant.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.createNewRestaurant, (route) => false);
      }
      if (status == SubscriptionStatus.restaurantSuspended.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.createNewRestaurant, (route) => false);
      }
      if (status == SubscriptionStatus.inactive.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.monthlyFee, (route) => false);
      }
      if (status == SubscriptionStatus.expired.title) {
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.monthlyFee, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AdminMonthlyFeeBloc bloc = AdminMonthlyFeeBloc(sl(), sl(), sl(), sl());
    return BlocProvider(
      create: (_) => bloc,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
              const Icon(Icons.logout, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Alert',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Are you sure you want to subscribe?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocConsumer<AdminMonthlyFeeBloc, MonthlyFeeState>(
                listener: (context, state) {
                  if (state.initResponse.status == Status.completed) {
                    final url = state.initResponse.data?.authorizationUrl ?? '';
                    final reference = state.initResponse.data?.reference ?? '';

                    PaymentWebViewService.openPaymentPage(
                      context: context,
                      paymentUrl: url,
                      reference: reference,
                      onVerify: (ref) {
                        bloc.add(VerifyPaymentSubmitted(state.initResponse.data?.reference??''));
                      },
                    );
                  }
                  if (state.verifyResponse.status == Status.completed) {
                    _handleLoginNavigation(context);
                  }
                  if (state.verifyResponse.status == Status.error) {
                    context.flushBarErrorMessage(message: 'this is the error');
                    _handleLoginNavigation(context);
                  }
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          onPressed: () => Navigator.pop(context),
                          text: "Cancel",
                          bgColor: Colors.white,
                          textColor: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          onPressed: () {
                            bloc.add(InitPaymentSubmitted(amount));
                          },
                          text: "Continue",
                          isLoading:
                              state.initResponse.status == Status.loading,
                          bgColor: AppColors.darkOrange,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
