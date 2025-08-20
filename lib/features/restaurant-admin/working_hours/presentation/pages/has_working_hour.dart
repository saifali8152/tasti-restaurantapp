import 'package:flutter/widgets.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/custom_button.dart';
import '/features/restaurant-admin/working_hours/domain/entities/working_hour.dart';
import '/features/restaurant-admin/working_hours/presentation/widgets/working_hour_tile.dart';
import '../widgets/add_hours_header.dart';

class HasWorkingHour extends StatelessWidget {
  final WorkingHourEntity entity;
  const HasWorkingHour({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddHoursHeader(),
        WorkingHourTile(title: "Monday", value: entity.monday),
        WorkingHourTile(title: "Tuesday", value: entity.tuesday),
        WorkingHourTile(title: "Wednesday", value: entity.wednesday),
        WorkingHourTile(title: "Thursday", value: entity.thursday),
        WorkingHourTile(title: "Friday", value: entity.friday),
        WorkingHourTile(title: "Saturday", value: entity.saturday),
        WorkingHourTile(title: "Sunday", value: entity.sunday),
        SizedBox(height: 20),
        CustomButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.updateWorkingHours,
                arguments: entity,
              );
            },
            text: "Update Hours")
      ],
    );
  }
}
