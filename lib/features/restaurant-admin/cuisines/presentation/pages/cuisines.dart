import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_event.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_dropdown.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/widgets/attributes_dropdown.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/widgets/cuisine_form.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/label_text.dart';

class CuisinesScreen extends StatefulWidget {
  const CuisinesScreen({super.key});

  @override
  State<CuisinesScreen> createState() => _CuisinesScreenState();
}

class _CuisinesScreenState extends State<CuisinesScreen> {
  final CuisineBloc bloc = sl();
  String cuisine = '';
  String type = '';
  String attribute = '';

  final int id = 10;

  @override
  void initState() {
    bloc.add(FetchCuisineEvent(id.toString()));
    super.initState();
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
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(FetchCuisineEvent(id.toString()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: AppColors.darkOrange,
                  indicatorColor: Colors.deepOrange,
                  splashFactory: NoSplash.splashFactory,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Cuisines"),
                    Tab(text: "Types"),
                    Tab(text: "Attributes"),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<CuisineBloc, CuisineState>(
                    bloc: bloc,
                    builder: (context, state) {
                      return TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CuisineForm(
                                cuisine: state.fetchCuisine.data ?? [],
                                type: "cuisine",
                              ),
                              LabelText(text: "Select Vanue Category"),
                              SizedBox(height: 10),
                              CustomDropdown(
                                items: cuisineDropdownItems,
                                onChanged: (value) {
                                  cuisine = value;
                                },
                                hintText: "Select",
                              ),
                              const SizedBox(height: 30),
                              BlocConsumer<CuisineBloc, CuisineState>(
                                bloc: bloc,
                                listener: (context, state) {
                                  if (state.addCuisine.status == Status.error) {
                                    return context.flushBarErrorMessage(
                                        message: state.addCuisine.message
                                            .toString());
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton(
                                    isLoading: state.addCuisine.status ==
                                        Status.loading,
                                    onPressed: () {
                                      bloc.add(AddCuisineEvent(AddCuisineParms(
                                          id: id,
                                          name: cuisine,
                                          type: "cuisine")));
                                    },
                                    text: 'Save',
                                  );
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CuisineForm(
                                cuisine: state.fetchCuisine.data ?? [],
                                type: "type",
                              ),
                              LabelText(text: "Select Vanue Category"),
                              SizedBox(height: 10),
                              CustomDropdown(
                                items: typesDropdownItems,
                                onChanged: (value) {
                                  type = value;
                                },
                                hintText: "Select",
                              ),
                              const SizedBox(height: 30),
                              BlocConsumer<CuisineBloc, CuisineState>(
                                bloc: bloc,
                                listener: (context, state) {
                                  if (state.addCuisine.status == Status.error) {
                                    return context.flushBarErrorMessage(
                                        message: state.addCuisine.message
                                            .toString());
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton(
                                    isLoading: state.addCuisine.status ==
                                        Status.loading,
                                    onPressed: () {
                                      bloc.add(
                                        AddCuisineEvent(
                                          AddCuisineParms(
                                            id: id,
                                            name: type,
                                            type: "type",
                                          ),
                                        ),
                                      );
                                    },
                                    text: 'Save',
                                  );
                                },
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CuisineForm(
                                cuisine: state.fetchCuisine.data ?? [],
                                type: "attribute",
                              ),
                              LabelText(text: "Select Vanue Category"),
                              SizedBox(height: 10),
                              CustomDropdown(
                                items: typesDropdownItems,
                                onChanged: (value) {
                                  attribute = value;
                                },
                                hintText: "Select",
                              ),
                              const SizedBox(height: 30),
                              BlocConsumer<CuisineBloc, CuisineState>(
                                bloc: bloc,
                                listener: (context, state) {
                                  if (state.addCuisine.status == Status.error) {
                                    return context.flushBarErrorMessage(
                                        message: state.addCuisine.message
                                            .toString());
                                  }
                                },
                                builder: (context, state) {
                                  return CustomButton(
                                    isLoading: state.addCuisine.status ==
                                        Status.loading,
                                    onPressed: () {
                                      bloc.add(
                                        AddCuisineEvent(
                                          AddCuisineParms(
                                            id: id,
                                            name: attribute,
                                            type: "attribute",
                                          ),
                                        ),
                                      );
                                    },
                                    text: 'Save',
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
