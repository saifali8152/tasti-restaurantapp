import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/widgets/attributes_dropdown.dart';
import 'package:tasti_restaurant_app/core/widgets/curved_container.dart';
import 'package:tasti_restaurant_app/core/widgets/themed_app_bar.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/widgets/tab_content.dart';

class CuisinesScreen extends StatefulWidget {
  const CuisinesScreen({super.key});

  @override
  State<CuisinesScreen> createState() => _CuisinesScreenState();
}

class _CuisinesScreenState extends State<CuisinesScreen> {
  final CuisineBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  String cuisine = '';
  String type = '';
  String attribute = '';

  @override
  void initState() {
    super.initState();
    bloc.add(FetchCuisineEvent(id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.darkOrange,
        appBar: ThemedAppBar(
          height: 100,
          title: "Add Cuisines & More",
        ),
        body: CurvedContainer(
          child: BlocBuilder<CuisineBloc, CuisineState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.fetchCuisine.status == Status.loading) {
                return const Center(child: LoadingWidget());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: AppColors.darkOrange,
                    indicatorColor: Colors.deepOrange,
                    splashFactory: NoSplash.splashFactory,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "Cuisines"),
                      Tab(text: "Types"),
                      Tab(text: "Attributes"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CuisineTabContent(
                          type: "cuisine",
                          dropdownItems: cuisineDropdownItems,
                          selectedValue: cuisine,
                          onChanged: (value) => setState(() => cuisine = value),
                          bloc: bloc,
                          id: id,
                        ),
                        CuisineTabContent(
                          type: "type",
                          dropdownItems: typesDropdownItems,
                          selectedValue: type,
                          onChanged: (value) => setState(() => type = value),
                          bloc: bloc,
                          id: id,
                        ),
                        CuisineTabContent(
                          type: "attribute",
                          dropdownItems: typesDropdownItems,
                          selectedValue: attribute,
                          onChanged: (value) => setState(() => attribute = value),
                          bloc: bloc,
                          id: id,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
