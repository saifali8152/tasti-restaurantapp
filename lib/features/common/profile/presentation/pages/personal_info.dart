import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import '/config/constants/spaces.dart';
import '/core/widgets/custom_input_field.dart';
import '../bloc/update_profile/profile_bloc.dart';
import '../widgets/profile_image.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../skaleton/user_cubit/skaleton_cubit.dart';
import '../../../skaleton/cubit/skaleton_cubit.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import '/dependency_injection.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final ProfileBloc bloc = sl<ProfileBloc>();
  final UserEntity? user = sl<UserCubit>().state.user;
  late TextEditingController nameC;

  @override
  void initState() {
    nameC = TextEditingController(text: user!.name);
    bloc.add(SetProfilePic(user!.profilePic));
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpaces.screenHpad),
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) =>
                previous.response.status != current.response.status,
            listener: (context, state) {
              if (state.response.status == Status.completed) {
                Navigator.pop(context);
                context.flushBarSuccessMessage(message: state.response.data.toString());
              } else if (state.response.status == Status.error) {
                context.flushBarErrorMessage(message: state.response.message ?? "");
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    ProfileImage(
                        bloc: bloc,
                        networkImageUrl: state.profilePic,
                        isEditable: true),
                    const SizedBox(height: 10),
                    BlocBuilder<SkaletonCubit, SkaletonCubitState>(
                      builder: (context, state) {
                        return Text(
                          user?.name ?? "User Name",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomInputField(
                      hintText: "Name",
                      icon: Icons.person,
                      controller: nameC,
                    ),
                    CustomInputField(
                      hintText: user?.email ?? "Email",
                      icon: Icons.email,
                      readOnly: true,
                    ),
                    CustomInputField(
                      hintText: user?.phoneNumber ?? "Phone Number",
                      icon: Icons.phone,
                      readOnly: true,
                    ),
                    // const SizedBox(height: 20),
                    // CustomTile(
                    //   leading: const Icon(Icons.lock_outline),
                    //   title: "Change Password",
                    //   onTap: () {
                    //     Navigator.pushNamed(context, RoutesName.changePassword);
                    //   },
                    // ),
                    const SizedBox(height: 20),
                    CustomButton(
                      isLoading: state.response.status == Status.loading,
                      onPressed: () {
                        bloc.add(UpdateProfile(nameC.text));
                      },
                      text: "Save",
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
