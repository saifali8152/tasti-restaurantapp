import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/add_sms_bundle_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/add_sms_bundle_event.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/add_sms_bundle_state.dart';
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

  final AddSmsBundleBloc bloc = sl<AddSmsBundleBloc>();

  final discountController = TextEditingController();

  @override
  void dispose() {
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add SMS Bundle'),
      body: BlocConsumer<AddSmsBundleBloc, AddSmsBundleState>(
        listener: (context, state) {
          if(state.addResposne.status == Status.error){
            return context.flushBarErrorMessage(message: state.addResposne.message.toString());
          }
          if(state.addResposne.status == Status.completed){
            Navigator.pop(context);
            return context.flushBarSuccessMessage(message: state.addResposne.data.toString());
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
                  const FieldLabel(title: "Product Owner"),
                  CustomInputField(
                    hintText: 'Enter owner name',
                    onChanged: (val) => bloc.add(SetOwnerEvent(val)),
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "SMS Quantity"),
                  CustomInputField(
                    hintText: 'Enter SMS quantity',
                    keyboardInputType: TextInputType.number,
                    onChanged: (val) {
                      final qty = int.tryParse(val) ?? 0;
                      bloc.add(SetQuantityEvent(qty));
                    },
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Price"),
                  CustomInputField(
                    hintText: 'Enter price',
                    keyboardInputType: TextInputType.number,
                    onChanged: (val) {
                      final price = int.tryParse(val) ?? 0;
                      bloc.add(SetPriceEvent(price));
                    },
                  ),
                  const SizedBox(height: 10),
                  const FieldLabel(title: "Discount"),
                  CustomInputField(
                    controller: discountController,
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
                  const SizedBox(height: 30),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bloc.add(SubmitSmsBundleEvent());
                      }
                    },
                    isLoading: state.addResposne.status == Status.loading,
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
