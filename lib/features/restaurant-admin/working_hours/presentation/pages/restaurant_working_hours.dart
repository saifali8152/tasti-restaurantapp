import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/core/widgets/loading_widget.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/pages/add_working_hours.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/pages/has_working_hour.dart';
import '/core/widgets/curved_container.dart';
import '/core/widgets/themed_app_bar.dart';
import '/config/constants/colors.dart';

class RestaurantWorkingHoursScreen extends StatefulWidget {
  const RestaurantWorkingHoursScreen({super.key});

  @override
  State<RestaurantWorkingHoursScreen> createState() =>
      _RestaurantWorkingHoursScreenState();
}

class _RestaurantWorkingHoursScreenState
    extends State<RestaurantWorkingHoursScreen> {
  final WorkingHoursBloc bloc = sl();
  final int id = SessionController().user?.restaurant.id ?? 0;

  @override
  void initState() {
    bloc.add(FetchWorkingHoursEvent(id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkOrange,
      appBar: ThemedAppBar(
        height: 150,
        title: "Working Hours",
        subTitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Please set your restaurant's working hours below.\nFormat: HH:MM-HH:MM (e.g. 09:00-22:00)",
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: BlocBuilder<WorkingHoursBloc, WorkingHoursState>(
        builder: (context, state) {
          return CurvedContainer(
            child: state.fetchResponse.status == Status.loading
                ? Center(child: LoadingWidget())
                : state.fetchResponse.data == null
                    ? AddWorkingHours(bloc: bloc, id: id)
                    : HasWorkingHour(entity: state.fetchResponse.data!),
          );
        },
      ),
    );
  }
}
