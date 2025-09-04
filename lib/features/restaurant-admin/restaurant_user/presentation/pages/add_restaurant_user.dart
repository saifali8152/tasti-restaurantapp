import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/constants/restaurant_permissions.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/widgets/permission_chip.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/widgets/field_label.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';

class AddRestaurantUserScreen extends StatefulWidget {
  final AddRestaurantUserParms? initialData;
  final bool isEdit;

  const AddRestaurantUserScreen({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  State<AddRestaurantUserScreen> createState() => _AddRestaurantUserScreenState();
}

class _AddRestaurantUserScreenState extends State<AddRestaurantUserScreen> {
  final RestaurantUserBloc bloc = sl();
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
        final match = restaurantUserPermissions.firstWhere(
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

    for (var p in restaurantUserPermissions) {
      p.isSelected = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit ? "Edit User" : "Add User",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
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
                        validator: (value) => null,
                      ),
                      const SizedBox(height: 12),
                      FieldLabel(title: "Phone Number"),
                      CustomInputField(
                        hintText: "Enter phone number",
                        controller: phoneController,
                      ),
                      const SizedBox(height: 20),
                      FieldLabel(title: "Permissions"),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: restaurantUserPermissions.map((p) {
                          return PermissionChip(
                            p: p,
                            onSelected: () {
                              setState(() {
                                p.isSelected = !p.isSelected;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const Spacer(), // pushes button to bottom if space is available
                      BlocConsumer<RestaurantUserBloc, RestaurantUserState>(
                        listener: (context, state) {
                          if (state.addResponse.status == Status.error) {
                            context.flushBarErrorMessage(
                                message: state.addResponse.message.toString());
                          } else if (state.addResponse.status ==Status.completed) {
                            Navigator.pop(context, true);
                            _resetForm();
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: widget.isEdit ? "Update User" : "Save User",
                            isLoading: widget.isEdit ? state.updateResponse.status == Status.loading :
                                state.addResponse.status == Status.loading,
                            onPressed: () {
                              final name = nameController.text.trim();
                              final email = emailController.text.trim();
                              final phone = phoneController.text.trim();
        
                              if (name.isEmpty || email.isEmpty || phone.isEmpty) {
                                _showSnackBar("All fields are required");
                                return;
                              }
        
                              final selectedPermissions = restaurantUserPermissions
                                  .where((p) => p.isSelected)
                                  .toList();
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
                                bloc.add(UpdateRestaurantUserEvent(parms));
                              } else {
                                bloc.add(AddRestaurantUserEvent(parms));
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
          },
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    context.flushBarErrorMessage(message: message);
  }
}
