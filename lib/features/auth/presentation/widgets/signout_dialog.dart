import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/features/skaleton/cubit/skaleton_cubit.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import '/dependency_injection.dart';
import '../bloc/signout/signout_bloc.dart';
import '../bloc/signout/signout_event.dart';
import '../bloc/signout/signout_state.dart';
import '/config/routes/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final SignOutBloc bloc = sl<SignOutBloc>();
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
                'Do you want to Logout? Once you logout you will need to login again.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocConsumer<SignOutBloc, SignOutState>(
                listener: (context, state) {
                  if (state is SignOutError) {
                    context.flushBarErrorMessage(message: state.message);
                  }
                  if (state is SignOutSuccess) {
                    Navigator.pop(context);
                    context.go(AppRoutes.login);
                    context.read<SkaletonCubit>().changeTab(0);
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
                            bloc.add(SignOutRequested());
                          },
                          text: "Logout",
                          isLoading: state is SignOutLoading,
                          bgColor: Colors.red,
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
