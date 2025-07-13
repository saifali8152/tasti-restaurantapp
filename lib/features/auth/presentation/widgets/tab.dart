import 'package:flutter/material.dart';
import '../bloc/auth/auth_bloc.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final AuthBloc authBloc;

  const CustomTab({super.key, required this.title, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    final isSelected = title == "Register" ? authBloc.state.isRegister : !authBloc.state.isRegister;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          authBloc.add(IsRegisterEvent(isRegister: title == "Register"));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
