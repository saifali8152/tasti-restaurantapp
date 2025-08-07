import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/core/widgets/image_picker_widget.dart';
import 'package:tasti_restaurant_app/core/widgets/phone_input_field.dart';
import 'package:tasti_restaurant_app/features/common/auth/presentation/widgets/auth_stack.dart';
import 'package:tasti_restaurant_app/features/common/location/presentation/bloc/location_bloc.dart';
import 'package:tasti_restaurant_app/features/common/location/presentation/widgets/location_dropdown_field.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_state.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '../bloc/create_new_restaurant_event.dart';

class CreateNewRestaurant extends StatefulWidget {
  const CreateNewRestaurant({super.key});

  @override
  State<CreateNewRestaurant> createState() => _CreateNewRestaurantState();
}

class _CreateNewRestaurantState extends State<CreateNewRestaurant> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bloc = sl<CreateNewRestaurantBloc>();
  final locationBloc = sl<LocationBloc>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dressCodeController = TextEditingController();
  final TextEditingController minimumSpendController = TextEditingController();
  final TextEditingController cuisineController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedImage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    websiteController.dispose();
    dressCodeController.dispose();
    minimumSpendController.dispose();
    cuisineController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _handleLoginNavigation(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.monthlyFee, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthStack(
      title: "Create New Restaurant",
      subtitle: "Create a new restaurant account",
      child: BlocProvider(
        create: (context) => bloc,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 40),
                CustomInputField(
                  icon: Icons.person_outline,
                  hintText: "Restaurant name",
                  controller: nameController,
                  keyboardInputType: TextInputType.text,
                ),
                CustomInputField(
                  icon: Icons.email_outlined,
                  hintText: "Restaurant email address",
                  controller: emailController,
                  keyboardInputType: TextInputType.emailAddress,
                ),
                PhoneInputField(
                  onChanged: (value) {
                    phoneController.text = value;
                  },
                ),
                CustomInputField(
                  icon: Icons.web,
                  hintText: "Restaurant website",
                  controller: websiteController,
                ),
                BlocProvider.value(
                  value: locationBloc,
                  child: LocationDropdownField(
                    bloc: locationBloc,
                  ),
                ),
                CustomInputField(
                  icon: Icons.style,
                  hintText: "Restaurant dressing code",
                  controller: dressCodeController,
                ),
                CustomInputField(
                  icon: Icons.attach_money,
                  hintText: "Minimum spend",
                  controller: minimumSpendController,
                  keyboardInputType: TextInputType.number,
                ),
                CustomInputField(
                  icon: Icons.restaurant_menu,
                  hintText: "Restaurant cuisine",
                  controller: cuisineController,
                ),
                CustomInputField(
                  icon: Icons.description,
                  hintText: "Restaurant description",
                  controller: descriptionController,
                  maxLines: 3,
                ),
                ImagePickerWidget(
                  onImagePicked: (image) {
                    selectedImage = image.path;
                  },
                ),
                const SizedBox(height: 24),
                BlocConsumer<CreateNewRestaurantBloc, CreateNewRestaurantState>(
                  bloc: bloc,
                  listener: (context, state) {
                    if (state.createRestaurantResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                        message: state.createRestaurantResponse.message ??
                            "Error Occurred",
                      );
                    }
                    if (state.createRestaurantResponse.status ==
                        Status.completed) {
                      _handleLoginNavigation(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state.createRestaurantResponse.status ==
                          Status.loading,
                      text: "Submit",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          bloc.add(CreateNewRestaurantSubmitted(
                              CreateRestaurantParms(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: emailController.text.trim(),
                            website: websiteController.text.trim(),
                            address: locationBloc.state.locationAddress ?? '',
                            city: locationBloc.state.location?.city ?? "",
                            lat: locationBloc.state.location?.lat.toString() ??
                                "",
                            lon: locationBloc.state.location?.lng.toString() ??
                                "",
                            dressCode: dressCodeController.text.trim(),
                            minimumSpend: minimumSpendController.text.trim(),
                            description: descriptionController.text.trim(),
                            cuisines: cuisineController.text.trim(),
                            image: selectedImage ?? '',
                          )));
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have a restaurant? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
