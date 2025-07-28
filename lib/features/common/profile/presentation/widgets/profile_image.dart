import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '/core/widgets/image_picker_dialog.dart';
import '../bloc/update_profile/profile_bloc.dart';
import '/core/widgets/loading_widget.dart';
import '/config/constants/colors.dart';
import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';

class ProfileImage extends StatelessWidget {
  final ProfileBloc? bloc;
  final String networkImageUrl;
  final bool isEditable;

  const ProfileImage({
    super.key,
    this.bloc,
    required this.networkImageUrl,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    final hasLocalImage = !networkImageUrl.contains("http");
    final hasNetworkImage = networkImageUrl.isNotEmpty;

    Widget buildProfileImage() {
      if (hasLocalImage && bloc?.state.profilePic.isNotEmpty == true) {
        return Image.file(
          File(bloc!.state.profilePic),
          fit: BoxFit.cover,
        );
      } else if (hasNetworkImage) {
        return CachedNetworkImage(
          imageUrl: networkImageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: LoadingWidget(),
          ),
          errorWidget: (context, url, error) => CircleAvatar(
            backgroundColor: Colors.grey.withSafeOpacity(.5),
            child: const Icon(
              Icons.person,
              size: 50,
              color: AppColors.black,
            ),
          ),
        );
      } else {
        return const Icon(
          Icons.person,
          size: 50,
          color: AppColors.black,
        );
      }
    }

    Widget avatar = SizedBox(
      width: 100,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: buildProfileImage(),
      ),
    );

    return Column(
      children: [
        Center(
          child: isEditable
              ? GestureDetector(
                  onTap: () {
                    if (bloc == null) return;

                    context.showCustomDialog(
                      ImagePickerDialog(
                        onCameraTap: () {
                          bloc!.add(
                            ProfileImageChanged(source: ImageSource.camera),
                          );
                        },
                        onGalleryTap: () {
                          bloc!.add(
                            ProfileImageChanged(source: ImageSource.gallery),
                          );
                        },
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: avatar,
                      ),
                      const Positioned(
                        bottom: 5,
                        right: 5,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.white,
                          child: Icon(
                            Icons.camera_alt,
                            size: 15,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : avatar,
        ),
      ],
    );
  }
}
