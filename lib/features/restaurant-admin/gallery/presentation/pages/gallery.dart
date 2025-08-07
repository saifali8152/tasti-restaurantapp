import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/bloc/gallery_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/bloc/gallery_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/widgets/food_card.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../../config/constants/icons.dart';
import '../../../../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final GalleryBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  String cuisine = '';
  String type = '';
  String attribute = '';

  @override
  void initState() {
    super.initState();
    bloc.add(FetchGalleryEvent(id.toString()));
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(context, AppRoutes.addPhotos);
          },
          bgColor: const Color(0xFF9747FF),
        ),
      ),
      body: CurvedContainer(
        child: BlocBuilder<GalleryBloc, GalleryState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.fetchResponse.status == Status.loading) {
              return Center(child: LoadingWidget());
            }
            if (state.fetchResponse.status == Status.completed &&
                state.fetchResponse.data!.isEmpty) {
              return Center(child: Text("Nothing Found!"));
            }
            if (state.fetchResponse.status == Status.error) {
              return Center(child: Text(state.fetchResponse.message ?? ''));
            }
            return ClipRRect(
              borderRadius:
                  BorderRadiusGeometry.vertical(top: Radius.circular(16)),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.fetchResponse.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = state.fetchResponse.data?[index];
                  return FoodCard(
                    gallery: item!,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
