import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/core/widgets/image_picker_widget.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_event.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_state.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  String _pickedImage = '';

  void _submit() {
    if (_formKey.currentState!.validate() && _pickedImage.isNotEmpty) {
      final title = _titleController.text.trim();
      final link = _linkController.text.trim();
      final image = _pickedImage;

      final parms = AddEventParms(title: title, link: link, image:image);

      context.read<EventBloc>().add(
        AddEvent(parms),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please complete the form and pick an image.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add New Event"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomInputField(
                controller: _titleController,
                hintText: 'Event Title',
                icon: Icons.title,
              ),
              const SizedBox(height: 16),
              CustomInputField(
                controller: _linkController,
                hintText: 'Event Link',
                icon: Icons.link,
              ),
              const SizedBox(height: 16),
              ImagePickerField(
                onImagePicked: (file) => _pickedImage = file.path,
              ),
              const SizedBox(height: 30),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: _submit,
                    isLoading: state.addResponse.status == Status.loading,
                    text: "Add Event",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
