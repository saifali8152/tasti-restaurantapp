import 'package:flutter/material.dart';

class WorkingHourTile extends StatelessWidget {
  final String title;
  final String value;
  const WorkingHourTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 2, child: Text(value)),
        ],
      ),
    );
  }
}
