import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/config/constants/colors.dart';
import '/config/constants/spaces.dart';
import '/config/routes/route_name.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/widgets/icon_button.dart';
import '/core/widgets/image_picker_widget.dart';
import '/core/widgets/phone_input_field.dart';
import '/core/widgets/themed_app_bar.dart';
import '/features/common/auth/domain/entities/user.dart';
import '/features/common/location/data/models/location_model.dart';
import '/features/common/location/presentation/bloc/location_bloc.dart';
import '/features/common/location/presentation/widgets/location_dropdown_field.dart';
import '/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_bloc.dart';
import '/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_state.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/dependency_injection.dart';
import '../bloc/create_new_restaurant_event.dart';

class UpdateNewRestaurant extends StatefulWidget {
  const UpdateNewRestaurant({super.key});

  @override
  State<UpdateNewRestaurant> createState() => _UpdateNewRestaurantState();
}

class _UpdateNewRestaurantState extends State<UpdateNewRestaurant> {
  final UserRestaurantEntity? currentRestaurant =
      SessionController().user?.restaurant;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bloc = sl<CreateNewRestaurantBloc>();
  final locationBloc = sl<LocationBloc>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController websiteController;
  late TextEditingController dressCodeController;
  late TextEditingController phoneController;
  late TextEditingController minimumSpendController;
  late TextEditingController cuisineController;
  late TextEditingController descriptionController;
  late String selectedImage;
  late TextEditingController costController;

  @override
  void initState() {
    nameController = TextEditingController(text: currentRestaurant?.name);
    emailController = TextEditingController(text: currentRestaurant?.email);
    websiteController = TextEditingController(text: currentRestaurant?.website);
    costController = TextEditingController(text: currentRestaurant?.cost);
    dressCodeController =
        TextEditingController(text: currentRestaurant?.dressCode);
    minimumSpendController =
        TextEditingController(text: currentRestaurant?.minimumSpend);
    String cleanPhone = currentRestaurant?.phone.startsWith('+27') ?? false
        ? currentRestaurant?.phone.replaceFirst('+27', '') ?? ''
        : currentRestaurant?.phone ?? '';
    phoneController = TextEditingController(text: cleanPhone);
    cuisineController =
        TextEditingController(text: currentRestaurant?.cuisines);
    descriptionController =
        TextEditingController(text: currentRestaurant?.description);
    selectedImage = currentRestaurant?.cuisineImage ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    websiteController.dispose();
    phoneController.dispose();
    dressCodeController.dispose();
    minimumSpendController.dispose();
    cuisineController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        height: 110,
        title: 'Restaurant Settings',
        subTitle: ButtonWithIcon(
          icon: Icon(Icons.home,
              color: Colors.white, size: AppSpaces.iconsHeight),
          title: 'Set Venue Category',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.setVanueCategory);
          },
          bgColor: Color(0xFF0D49AA),
        ),
      ),
      backgroundColor: AppColors.darkOrange,
      body: CurvedContainer(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => bloc,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ImagePickerWidget(
                    initialImage: selectedImage,
                    onImagePicked: (image) {
                      selectedImage = image.path;
                    },
                    showButton: true,
                  ),
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
                    controller: phoneController,
                    onChanged: (p0) {
                      phoneController.text = p0;
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
                        initialDescription: currentRestaurant?.address,
                        initialLocation: LocationModel(
                          lat: currentRestaurant?.lat ?? 0,
                          lng: currentRestaurant?.lon ?? 0,
                          city: currentRestaurant?.city ?? '',
                        ),
                      )),
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
                    icon: Icons.price_change,
                    hintText: "Cost",
                    controller: costController,
                  ),
                  CustomInputField(
                    hintText: "Restaurant description",
                    controller: descriptionController,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<CreateNewRestaurantBloc,
                      CreateNewRestaurantState>(
                    bloc: bloc,
                    listener: (context, state) {
                      if (state.updateRestaurantResponse.status ==
                          Status.error) {
                        context.flushBarErrorMessage(
                          message: state.updateRestaurantResponse.message ??
                              "Error Occurred",
                        );
                      }
                      if (state.updateRestaurantResponse.status ==
                          Status.completed) {}
                    },
                    builder: (context, state) {
                      return CustomButton(
                        isLoading: state.updateRestaurantResponse.status ==
                            Status.loading,
                        text: "update",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(UpdateNewRestaurantSubmitted(
                                UpdateRestaurantParms(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              phone: "+27${phoneController.text.trim()}",
                              website: websiteController.text.trim(),
                              address: locationBloc.state.locationAddress ?? '',
                              city: locationBloc.state.location?.city ?? "",
                              lat:
                                  locationBloc.state.location?.lat.toString() ??
                                      "",
                              lon:
                                  locationBloc.state.location?.lng.toString() ??
                                      "",
                              dressCode: dressCodeController.text.trim(),
                              minimumSpend: minimumSpendController.text.trim(),
                              cost: costController.text.trim(),
                              description: descriptionController.text.trim(),
                              cuisines: cuisineController.text.trim(),
                              image: selectedImage,
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
      ),
    );
  }
}
