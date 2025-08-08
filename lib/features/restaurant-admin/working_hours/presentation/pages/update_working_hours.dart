import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/utils/flushbar_extention.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/entities/working_hour.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_state.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/widgets/add_hours_header.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/widgets/add_hours_row.dart';

class UpdateWorkingHours extends StatefulWidget {
  final WorkingHourEntity workingHours;

  const UpdateWorkingHours({super.key, required this.workingHours});

  @override
  State<UpdateWorkingHours> createState() => _UpdateWorkingHoursState();
}

class _UpdateWorkingHoursState extends State<UpdateWorkingHours> {
  final List<String> _weekDays = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  late final Map<String, TextEditingController> _controllers;
  final WorkingHoursBloc bloc = sl();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (var day in _weekDays) day: TextEditingController(),
    };
    _controllers["Monday"]!.text = widget.workingHours.monday == "Closed"? "" : widget.workingHours.monday;
    _controllers["Tuesday"]!.text = widget.workingHours.tuesday == "Closed"? "" : widget.workingHours.tuesday;
    _controllers["Wednesday"]!.text = widget.workingHours.wednesday  == "Closed"? "" : widget.workingHours.wednesday;
    _controllers["Thursday"]!.text = widget.workingHours.thursday == "Closed"? "" : widget.workingHours.thursday;
    _controllers["Friday"]!.text = widget.workingHours.friday == "Closed"? "" : widget.workingHours.friday;
    _controllers["Saturday"]!.text = widget.workingHours.saturday == "Closed"? "" : widget.workingHours.saturday;
    _controllers["Sunday"]!.text = widget.workingHours.sunday == "Closed"? "" : widget.workingHours.sunday;
  }

  @override
  void dispose() {
    for (var ctrl in _controllers.values) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Update Working Hours"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Please set your restaurant's working hours below.\nFormat: HH:MM-HH:MM (e.g. 09:00-22:00)",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const AddHoursHeader(),
            const SizedBox(height: 10),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  itemCount: _weekDays.length,
                  itemBuilder: (context, index) {
                    final day = _weekDays[index];
                    return AddHoursRow(
                      title: day,
                      controller: _controllers[day]!,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<WorkingHoursBloc, WorkingHoursState>(
              listener: (context, state) {
                if (state.updateResponse.status == Status.error) {
                  context.flushBarErrorMessage(
                      message: state.updateResponse.message.toString());
                }
                if (state.updateResponse.status == Status.completed) {
                  Navigator.pop(context);
                }
              },
              bloc: bloc,
              builder: (context, state) {
                return CustomButton(
                  isLoading: state.updateResponse.status == Status.loading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final params = UpdateWorkingHourParms(
                        id: int.parse(widget.workingHours.restaurantId),
                        monday: _controllers["Monday"]!.text,
                        tuesday: _controllers["Tuesday"]!.text,
                        wednesday: _controllers["Wednesday"]!.text,
                        thursday: _controllers["Thursday"]!.text,
                        friday: _controllers["Friday"]!.text,
                        saturday: _controllers["Saturday"]!.text,
                        sunday: _controllers["Sunday"]!.text,
                      );
                      bloc.add(UpdateWorkingHoursEvent(params));
                    }
                  },
                  text: "Save Working Hours",
                );
              },
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
