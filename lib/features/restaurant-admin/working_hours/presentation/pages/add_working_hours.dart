import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/widgets/custom_button.dart';
import '/features/restaurant-admin/working_hours/presentation/bloc/working_hours_bloc.dart';
import '/features/restaurant-admin/working_hours/presentation/bloc/working_hours_event.dart';
import '/features/restaurant-admin/working_hours/presentation/bloc/working_hours_state.dart';
import '/features/restaurant-admin/working_hours/presentation/widgets/add_hours_header.dart';
import '/features/restaurant-admin/working_hours/presentation/widgets/add_hours_row.dart';

class AddWorkingHours extends StatefulWidget {
  final int id;
  final WorkingHoursBloc bloc;
  const AddWorkingHours({super.key, required this.bloc, required this.id});

  @override
  State<AddWorkingHours> createState() => _AddWorkingHoursState();
}

class _AddWorkingHoursState extends State<AddWorkingHours> {
  final List<String> _weekDays = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final _formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (var day in _weekDays) day: TextEditingController(),
    };
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
    return Column(
      children: [
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
        BlocBuilder<WorkingHoursBloc, WorkingHoursState>(
          bloc: widget.bloc,
          builder: (context, state) {
            return CustomButton(
              isLoading: state.addResponse.status == Status.loading,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final params = AddWorkingHourParms(
                    id: widget.id,
                    monday: _controllers["Monday"]!.text,
                    tuesday: _controllers["Tuesday"]!.text,
                    wednesday: _controllers["Wednesday"]!.text,
                    thursday: _controllers["Thursday"]!.text,
                    friday: _controllers["Friday"]!.text,
                    saturday: _controllers["Saturday"]!.text,
                    sunday: _controllers["Sunday"]!.text,
                  );
                  widget.bloc.add(AddWorkingHoursEvent(params));
                }
              },
              text: "Save Working Hours",
            );
          },
        ),
      ],
    );
  }
}
