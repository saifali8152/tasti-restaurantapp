import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/constants/restaurant_permissions.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/widgets/curved_container.dart';
import 'package:tasti_restaurant_app/core/widgets/themed_app_bar.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/seating_area_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/seating_area_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/seating_area_state.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/widgets/field_label.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';

class AddUserScreen extends StatefulWidget {
  final AddRestaurantUserParms? initialData;
  final bool isEdit;

  const AddUserScreen({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final UserBloc bloc = sl();
  final int restaurantId = SessionController().user?.restaurant.id ?? 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.initialData != null) {
      nameController.text = widget.initialData!.name;
      emailController.text = widget.initialData!.email;
      phoneController.text = widget.initialData!.phoneNumber;

      for (var p in widget.initialData!.permissions) {
        final match = permissions.firstWhere(
          (x) => x.key == p.key,
          orElse: () => p,
        );
        match.isSelected = true;
      }
    }
  }

  /// Reset form fields and uncheck permissions
  void _resetForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();

    for (var p in permissions) {
      p.isSelected = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: widget.isEdit ? "Edit User" : "Add User",
      ),
      backgroundColor: AppColors.darkOrange,
      body: CurvedContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldLabel(title: "Name"),
              CustomInputField(
                hintText: "Enter name",
                controller: nameController,
              ),
              const SizedBox(height: 12),
              FieldLabel(title: "Email"),
              CustomInputField(
                hintText: "Enter email",
                controller: emailController,
                validator: (value) {
                  return null;
                },
              ),
              const SizedBox(height: 12),
              FieldLabel(title: "Phone Number"),
              CustomInputField(
                hintText: "Enter phone number",
                controller: phoneController,
              ),
              const SizedBox(height: 20),
              FieldLabel(title: "Permissions"),
              Column(
                children: permissions.map((p) {
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(p.title),
                    value: p.isSelected,
                    onChanged: (val) {
                      setState(() {
                        p.isSelected = val ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.addResponse.status == Status.error) {
                    context.flushBarErrorMessage(message: state.addResponse.message.toString());
                  } else if (state.addResponse.status == Status.completed) {
                      context.flushBarErrorMessage(message: state.addResponse.data.toString());
                      _resetForm();
                    
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: widget.isEdit ? "Update User" : "Save User",
                    isLoading: state.addResponse.status == Status.loading,
                    onPressed: () {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final phone = phoneController.text.trim();

                      if (name.isEmpty || email.isEmpty || phone.isEmpty) {
                        _showSnackBar("All fields are required");
                        return;
                      }

                      final selectedPermissions =
                          permissions.where((p) => p.isSelected).toList();
                      if (selectedPermissions.isEmpty) {
                        _showSnackBar("Select at least one permission");
                        return;
                      }

                      final parms = AddRestaurantUserParms(
                        id: widget.isEdit ? widget.initialData?.id : null,
                        name: name,
                        email: email,
                        phoneNumber: phone,
                        restaurantId: restaurantId,
                        permissions: selectedPermissions,
                      );

                      if (widget.isEdit) {
                        // bloc.add(UpdateUserEvent(parms));
                      } else {
                        bloc.add(AddUserEvent(parms));
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    context.flushBarErrorMessage(message: message);
  }
}
