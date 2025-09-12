import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/widgets/custom_button.dart';
import '/core/widgets/custom_dropdown.dart';
import '/core/widgets/label_text.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/features/restaurant-admin/cuisines/presentation/bloc/cuisine_bloc.dart';
import '/features/restaurant-admin/cuisines/presentation/bloc/cuisine_event.dart';
import '/features/restaurant-admin/cuisines/presentation/bloc/cuisine_state.dart';
import '/features/restaurant-admin/cuisines/presentation/widgets/cuisine_form.dart';

class CuisineTabContent extends StatelessWidget {
  final String type;
  final List<DropdownMenuEntry<String>> dropdownItems;
  final String selectedValue;
  final Function(String) onChanged;
  final CuisineBloc bloc;
  final int id;

  const CuisineTabContent({
    super.key,
    required this.type,
    required this.dropdownItems,
    required this.selectedValue,
    required this.onChanged,
    required this.bloc,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuisineForm(
            cuisine: bloc.state.fetchCuisine.data ?? [],
            type: type,
          ),
          const SizedBox(height: 10),
          LabelText(
            text: "Select ${type[0].toUpperCase()}${type.substring(1)}",
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            items: dropdownItems,
            onChanged: onChanged,
            hintText: "Select",
          ),
          const SizedBox(height: 30),
          BlocConsumer<CuisineBloc, CuisineState>(
            bloc: bloc,
            listener: (context, state) {
              if (state.addCuisine.status == Status.error) {
                context.flushBarErrorMessage(
                  message: state.addCuisine.message.toString(),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                isLoading: state.addCuisine.status == Status.loading,
                onPressed: () {
                  bloc.add(
                    AddCuisineEvent(
                      AddCuisineParms(
                        id: id,
                        name: selectedValue,
                        type: type,
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
    );
  }
}
