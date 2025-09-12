import 'package:tasti_restaurant_app/dependency_injection.dart';

import '/config/constants/colors.dart';
import '/config/routes/route_name.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/payment_webview_service.dart';
import '/core/services/session_controller.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_bloc.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_event.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_state.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class InitPaymentDialog extends StatelessWidget {
  final int bundleId;
  const InitPaymentDialog({super.key, required this.bundleId});

  void _handleLoginNavigation(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.skaleton, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final BundleBillingBloc bloc = sl();
    final int id = SessionController().user?.restaurant.id ?? 0;
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
                'Are you sure you want to proceed?',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocConsumer<BundleBillingBloc, BundleBillingState>(
                bloc: bloc,
                listener: (context, state) {
                  // Payment initialized
                  if (state.initPaymentResponse.status == Status.completed) {
                    
                    final url =
                        state.initPaymentResponse.data?.authorizationUrl ?? '';
                    final reference =
                        state.initPaymentResponse.data?.reference ?? '';

                    PaymentWebViewService.openPaymentPage(
                      context: context,
                      paymentUrl: url,
                      reference: reference,
                      onVerify: (ref) {
                        bloc.add(VerifySmsPayment(VerifySmsPaymentParms(
                          reference: ref,
                          restaurantId: id.toString(),
                          bundleId: bundleId.toString(),
                        )));
                        context.flushBarSuccessMessage(message: "Verifying payment...");
                      },
                    );
                  }

                  // Init payment error
                  if (state.initPaymentResponse.status == Status.error) {
                    context.flushBarErrorMessage(
                      message: state.initPaymentResponse.message.toString(),
                    );
                  }

                  // Verification completed
                  if (state.verifyPaymentResponse.status == Status.completed) {
                    // Schedule navigation & flushbar in next frame for smoother UX
                    Future.microtask(() {
                      _handleLoginNavigation(context);
                      context.flushBarSuccessMessage(
                        message: state.verifyPaymentResponse.data.toString(),
                      );
                    });
                  }

                  // Verification error
                  if (state.verifyPaymentResponse.status == Status.error) {
                    Future.microtask(() {
                      context.flushBarErrorMessage(
                        message: state.verifyPaymentResponse.message.toString(),
                      );
                      _handleLoginNavigation(context);
                    });
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
                            bloc.add(InitSmsPayment(bundleId));
                          },
                          text: "Continue",
                          isLoading: state.initPaymentResponse.status ==
                              Status.loading,
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
