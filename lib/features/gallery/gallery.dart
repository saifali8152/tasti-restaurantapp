import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/config/constants/images.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../config/constants/icons.dart';
import '../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      AppImages.gallery1,
      AppImages.gallery2,
      AppImages.gallery3,
      AppImages.gallery4,
      AppImages.gallery2,
      AppImages.gallery1,
      AppImages.gallery4,
      AppImages.gallery3,
      AppImages.gallery4,
    ];
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 120,
        title: "Restaurant Gallery",
        subTitle: ButtonWithIcon(
          icon: Image.asset(
            AppIcons.add,
            color: Colors.white,
            height: 15,
          ),
          title: 'Add Photos',
          onTap: () {
            Navigator.pushNamed(context, RoutesName.addPhotos);
          },
          bgColor: const Color(0xFF9747FF),
        ),
      ),
      body: CurvedContainer(
        child: GridView.builder(
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Image.asset(images[index]);
          },
        ),
      ),
    );
  }
}
