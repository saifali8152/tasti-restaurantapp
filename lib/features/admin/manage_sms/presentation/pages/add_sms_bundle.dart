import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/field_label.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import '/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_event.dart';
import '/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_state.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';

class AddSMSBundle extends StatelessWidget {
  const AddSMSBundle({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddSMSBundleView();
  }
}

class AddSMSBundleView extends StatefulWidget {
  const AddSMSBundleView({super.key});

  @override
  State<AddSMSBundleView> createState() => _AddSMSBundleViewState();
}

class _AddSMSBundleViewState extends State<AddSMSBundleView> {
  final _formKey = GlobalKey<FormState>();

  final FetchAdminSmsBloc bloc = sl<FetchAdminSmsBloc>();

  final ownerController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final percentageController = TextEditingController();
  final discountController = TextEditingController();

  @override
  void dispose() {
    ownerController.dispose();
    quantityController.dispose();
    priceController.dispose();
    percentageController.dispose();
    discountController.dispose();
    super.dispose();
  }

  void _calculateDiscount() {
    final price = double.tryParse(priceController.text) ?? 0;
    final percentage = double.tryParse(percentageController.text) ?? 0;

    if (percentage > 0) {
      final discount = price - (price * percentage / 100);
      discountController.text = discount.toStringAsFixed(2);
    } else {
      discountController.text = '0';
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final parms = AddSMSBundleParms(
        owner: ownerController.text,
        quantity: int.tryParse(quantityController.text) ?? 0,
        price: int.tryParse(priceController.text) ?? 0,
        percentage: int.tryParse(percentageController.text) ?? 0,
        discount: double.tryParse(discountController.text) ?? 0,
      );

      bloc.add(AdminAddSmsRequested(parms));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add SMS Bundle'),
      body: BlocConsumer<FetchAdminSmsBloc, FetchAdminSmsLoaded>(
        listener: (context, state) {
          if (state.addResponse.status == Status.error) {
            return context.flushBarErrorMessage(
                message: state.addResponse.message.toString());
          }
          if (state.addResponse.status == Status.completed) {
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
                  const FieldLabel(title: "Product Owner"),
                  CustomInputField(
                    controller: ownerController,
                    hintText: 'Enter owner name',
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "SMS Quantity"),
                  CustomInputField(
                    controller: quantityController,
                    hintText: '0',
                    keyboardInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Price"),
                  CustomInputField(
                    controller: priceController,
                    hintText: '0',
                    keyboardInputType: TextInputType.number,
                    onChanged: (val) => _calculateDiscount(),
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount Percentage"),
                  CustomInputField(
                    controller: percentageController,
                    hintText: '0',
                    keyboardInputType: TextInputType.number,
                    onChanged: (val) => _calculateDiscount(),
                    enableValidation: false,
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount"),
                  CustomInputField(
                    controller: discountController,
                    readOnly: true,
                    enableValidation: false,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: _submit,
                    isLoading: state.addResponse.status == Status.loading,
                    text: 'Add SMS Bundle',
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