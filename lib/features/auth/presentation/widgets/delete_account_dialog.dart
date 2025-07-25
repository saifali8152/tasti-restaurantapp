import '/features/auth/presentation/bloc/delete_account/delete_account_bloc.dart';
import '/features/auth/presentation/bloc/delete_account/delete_account_event.dart';
import '/features/auth/presentation/bloc/delete_account/delete_account_state.dart';
import '/features/skaleton/cubit/skaleton_cubit.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import '/dependency_injection.dart';
import '/config/routes/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final DeleteAccountBloc bloc = sl<DeleteAccountBloc>();
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
                'Do you want to Delete account? Once you confirm all your data will be lost.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
                listener: (context, state) {
                  if (state is DeleteAccountError) {
                    context.flushBarErrorMessage(message: state.message);
                  }
                  if (state is DeleteAccountSuccess) {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
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
                            bloc.add(DeleteAccountRequested());
                          },
                          text: "Confirm",
                          isLoading: state is DeleteAccountLoading,
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
