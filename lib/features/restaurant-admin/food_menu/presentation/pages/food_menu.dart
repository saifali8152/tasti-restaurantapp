import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/loading_widget.dart';
import '/dependency_injection.dart';
import '/features/restaurant-admin/food_menu/presentation/bloc/menu_bloc.dart';
import '/features/restaurant-admin/food_menu/presentation/bloc/menu_event.dart';
import '/features/restaurant-admin/food_menu/presentation/bloc/menu_state.dart';
import '/features/restaurant-admin/food_menu/presentation/widgets/menu_button.dart';
import '/features/restaurant-admin/food_menu/presentation/widgets/pdf_picker_widget.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/themed_app_bar.dart';
import '../../../../../config/constants/icons.dart';
import '../../../../../core/widgets/icon_button.dart';
import '/config/constants/colors.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final MenuBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  // Hold the selected PDF file path here
  String? menuFile;

  @override
  void initState() {
    super.initState();
    bloc.add(FetchMenuEvent(id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.darkOrange,
          appBar: ThemedAppBar(
            height: 120,
            title: "Restaurant Food Menu",
            subTitle: ButtonWithIcon(
              icon: Image.asset(
                AppIcons.qr,
                color: Colors.white,
                height: 15,
              ),
              title: 'View QR Code',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.restaurantQRFoodMenu,
                  arguments: state.fetchResponse.data?.menu ?? "",
                );
              },
              bgColor: const Color(0xFF5A73E2),
            ),
          ),
          body: CurvedContainer(
            child: BlocBuilder<MenuBloc, MenuState>(
              bloc: bloc,
              builder: (context, state) {
                if(state.fetchResponse.status == Status.loading){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: LoadingWidget()),
                    ],
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PDFPickerWidget(
                        onFilePicked: (filePath) {
                          setState(() {
                            menuFile = filePath;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      if (state.fetchResponse.data?.isUploaded == 0)
                        MenuButton(
                          text: "View Menu Example",
                          menu: state.fetchResponse.data?.exampleMenu
                                  .toString() ??
                              "",
                        ),
                      if (state.fetchResponse.data?.isUploaded == 1)
                        MenuButton(
                          text: "View Menu",
                          menu: state.fetchResponse.data?.exampleMenu.toString() ?? "",
                        ),
                      const SizedBox(height: 20),
                      CustomButton(
                        isLoading: state.addResponse.status == Status.loading,
                        onPressed: () {
                          if (menuFile == null) {
                            context.flushBarErrorMessage(
                                message: "Select pdf to continue.");
                          } else {
                            bloc.add(
                              AddMenuEvent(
                                UploadMenuParms(
                                  id: id.toString(),
                                  menuFile: menuFile!,
                                ),
                              ),
                            );
                          }
                        },
                        text: "Upload",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
