import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/widgets/multiple_selection_dropdown.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/widgets/venue_data.dart';
import '/core/widgets/label_text.dart';
import '/config/constants/spaces.dart';
import '/core/widgets/custom_app_bar.dart';
import '/core/widgets/custom_button.dart';

class SetVenueCategory extends StatefulWidget {
  const SetVenueCategory({super.key});

  @override
  State<SetVenueCategory> createState() => _SetVenueCategoryState();
}

class _SetVenueCategoryState extends State<SetVenueCategory> {
  final VenueBloc bloc = sl();
  final int id = SessionController().user!.restaurant?.id;
  String selectedVanues = '';

  @override
  void initState() {
    bloc.add(FetchVenueEvent(id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Restaurant Vanue Categories',
      ),
      body: BlocBuilder<VenueBloc, VenueState>(
        bloc: bloc,
        builder: (context, state) {
          return state.fetchVenues.status == Status.loading
              ? Center(child: LoadingWidget())
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpaces.screenHpad, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.fetchVenues.data == null
                          ? Center(
                              child: Text(" No venue categories have been added yet"))
                          : VenueData(
                              id: id.toString(),
                              venue: state.fetchVenues.data!,
                            ),
                      SizedBox(height: 20),
                      LabelText(text: "Select Vanue Category"),
                      SizedBox(height: 10),
                      MultiSelectDropdown(
                        items: ['Bar', 'Restaurant', 'Night Club'],
                        initialSelected: state.fetchVenues.data?.name.trim().split(',').toList(),
                        hintText:
                             "Select Places",
                        onChanged: (venues) {
                          selectedVanues = venues;
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<VenueBloc, VenueState>(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state.addVenues.status == Status.error) {
                            return context.flushBarErrorMessage(
                                message: state.addVenues.message.toString());
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            isLoading: state.addVenues.status == Status.loading,
                            onPressed: () {
                              bloc.add(AddVenueEvent(AddVenueParms(
                                id: id,
                                names: selectedVanues,
                              )));
                            },
                            text: 'Save',
                          );
                        },
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
