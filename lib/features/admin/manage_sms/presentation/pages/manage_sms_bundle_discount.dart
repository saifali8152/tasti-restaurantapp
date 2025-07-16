import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/entities/admin_sms.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_bloc.dart';
import '/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_event.dart';
import '/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_state.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';

class ManageSmsBundleDiscountView extends StatefulWidget {
  final AdminSmsItem item;

  const ManageSmsBundleDiscountView({super.key, required this.item});

  @override
  State<ManageSmsBundleDiscountView> createState() =>
      _ManageSmsBundleDiscountViewState();
}

class _ManageSmsBundleDiscountViewState
    extends State<ManageSmsBundleDiscountView> {
  final _formKey = GlobalKey<FormState>();

  final ManageSmsBundleDiscountBloc bloc = sl<ManageSmsBundleDiscountBloc>();

  late TextEditingController priceController;
  late TextEditingController discountController;

  @override
  void initState() {
    priceController = TextEditingController(text: widget.item.amount);
    discountController = TextEditingController(text: widget.item.discount);
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Manage Discount'),
      body: BlocConsumer<ManageSmsBundleDiscountBloc, ManageSmsBundleDiscountState>(
        listener: (context, state) {
          if (state.manageDiscountResponse.status == Status.error) {
            return context.flushBarErrorMessage(
                message: state.manageDiscountResponse.message.toString());
          }
          if (state.manageDiscountResponse.status == Status.completed) {
            context.pop(context);
          }
        },
        bloc: bloc,
        builder: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            discountController.text = state.discount.toString();
          });

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Price"),
                  CustomInputField(
                    hintText: priceController.text.isEmpty ? '0' : priceController.text,
                    controller: priceController,
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount Percentage"),
                  CustomInputField(
                    hintText: 'Enter discount percentage',
                    keyboardInputType: TextInputType.number,
                    onChanged: (val) {
                      final percentage = int.tryParse(val) ?? 0;
                      bloc.add(SetPercentageEvent(percentage));
                    },
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount"),
                  CustomInputField(
                    controller: discountController,
                    readOnly: true,
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bloc.add(SubmitManageSmsBundleDiscountEvent(widget.item.id));
                      }
                    },
                    isLoading: state.manageDiscountResponse.status == Status.loading,
                    text: 'Apply Discount',
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
