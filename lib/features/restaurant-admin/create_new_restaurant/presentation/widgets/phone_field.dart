import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/create_new_restaurant_bloc.dart';
import '../bloc/create_new_restaurant_event.dart';
import '/config/constants/images.dart';

class CreateNewRestaurantPhoneField extends StatelessWidget {
  final CreateNewRestaurantBloc bloc;

  const CreateNewRestaurantPhoneField({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
    return TextFormField(
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      style: const TextStyle(fontWeight: FontWeight.normal),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Phone number",
        fillColor: Colors.white,
        filled: true,
        prefixIconColor: Colors.black,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        hintStyle: TextStyle(color: Colors.grey.shade600),
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.flag,
                width: 24,
                height: 16,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 6),
              const Text("+27", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      onChanged: (value) {
        bloc.add(PhoneNumberChanged(value));
      },
    );
  }
}
