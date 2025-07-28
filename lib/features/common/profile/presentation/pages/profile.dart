import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../skaleton/user_cubit/skaleton_cubit.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/custom_tile.dart';
import '../widgets/profile_image.dart';
import '../../../auth/presentation/widgets/delete_account_dialog.dart';
import '../../../auth/presentation/widgets/signout_dialog.dart';
import '/core/utils/general_extentions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserCubit, UserCubitState>(
        builder: (context, state) {
          final user = state.user;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileImage(
                  networkImageUrl: user?.profilePic??'',
                  isEditable: false,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    user?.name??'',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30),
                Text("About You",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                CustomTile(
                  leading: Icon(Icons.person_outline),
                  title: "Personal Information",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                ),
                CustomTile(
                  leading: Icon(Icons.lock_outline),
                  title: "Change Password",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.changePassword);
                  },
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Text("Help Center",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                CustomTile(
                  leading: Icon(Icons.help_outline_outlined),
                  title: "Contact Us",
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.contactUs);
                  },
                ),
                SizedBox(height: 20),
                Text("Account",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                CustomTile(
                  leading: Icon(Icons.logout),
                  title: "Logout",
                  onTap: () => context.showCustomDialog(LogoutDialog()),
                ),
                CustomTile(
                  leading: Icon(Icons.delete_forever),
                  title: "Delete Account",
                  onTap: () => context.showCustomDialog(DeleteAccountDialog()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
