import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_event.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_state.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';

class UpdateMonthlyFee extends StatefulWidget {
  final String id;
  const UpdateMonthlyFee({super.key, required this.id});

  @override
  State<UpdateMonthlyFee> createState() => _UpdateMonthlyFeeState();
}

class _UpdateMonthlyFeeState extends State<UpdateMonthlyFee> {
  final _formKey = GlobalKey<FormState>();

  final AdminMonthlyFeeBloc bloc = sl<AdminMonthlyFeeBloc>();

  final priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final parms = UpdateMonthlyFeeParms(
        id: widget.id,
        money: priceController.text.toString(),
      );

      bloc.add(UpdateMonthlyFeeSubmitted(parms));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Manage Monthly Fee'),
      body: BlocConsumer<AdminMonthlyFeeBloc, MonthlyFeeState>(
        listener: (context, state) {
          if (state.updateResponse.status == Status.error) {
            return context.flushBarErrorMessage(
                message: state.updateResponse.message.toString());
          }
          if (state.updateResponse.status == Status.completed) {
            Navigator.pop(context);
          }
        },
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const FieldLabel(title: "New Monthly Fee"),
                  CustomInputField(
                    controller: priceController,
                    hintText: 'New Monthly Fee',
                    keyboardInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: _submit,
                    isLoading: state.updateResponse.status == Status.loading,
                    text: 'Update',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class FieldLabel extends StatelessWidget {
  final String title;
  const FieldLabel({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.bold));
  }
}
