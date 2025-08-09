import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/field_label.dart';
import '/features/admin/manage_sms/domain/entities/admin_sms.dart';
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
  late TextEditingController percentageController;

  @override
  void initState() {
    super.initState();

    priceController = TextEditingController(text: widget.item.amount);
    discountController = TextEditingController(text: widget.item.discount);
    percentageController = TextEditingController();

    // Parse initial price (supports values like "100", "100.0" or with currency characters)
    final raw = widget.item.amount ?? '';
    final cleaned = raw.replaceAll(RegExp(r'[^0-9.]'), '');
    final initialPriceDouble = double.tryParse(cleaned) ?? 0.0;
    final initialPrice = initialPriceDouble.round();

    // Ensure bloc has the initial price so subsequent percentage changes compute correctly
    bloc.add(SetPriceEvent(initialPrice));
  }

  @override
  void dispose() {
    priceController.dispose();
    discountController.dispose();
    percentageController.dispose();
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
            Navigator.pop(context);
          }
        },
        bloc: bloc,
        builder: (context, state) {
          // Keep the read-only discount field in sync with bloc state
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final discountText = state.discount.toString();
            if (discountController.text != discountText) {
              discountController.text = discountText;
            }
            // Optionally keep percentageController in sync if you store percentage in state
            // percentageController.text = state.percentage > 0 ? state.percentage.toString() : '';
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
                  // Make price editable and dispatch SetPriceEvent on changes
                  CustomInputField(
                    hintText: '0',
                    controller: priceController,
                    readOnly: false,
                    keyboardInputType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (val) {
                      // parse decimals as well, round to nearest int
                      final cleaned = val.replaceAll(RegExp(r'[^0-9.]'), '');
                      final parsed = double.tryParse(cleaned) ?? 0.0;
                      final newPrice = parsed.round();
                      bloc.add(SetPriceEvent(newPrice));
                    },
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount Percentage"),
                  CustomInputField(
                    hintText: 'Enter discount percentage',
                    controller: percentageController,
                    keyboardInputType: TextInputType.number,
                    onChanged: (val) {
                      final percentage = int.tryParse(val) ?? 0;
                      bloc.add(SetManageDiscountPercentageEvent(percentage));
                    },
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount"),
                  // read-only discounted amount
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
