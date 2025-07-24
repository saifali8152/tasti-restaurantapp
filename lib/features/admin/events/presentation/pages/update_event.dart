import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_app_bar.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_button.dart';
import 'package:tasti_restaurant_app/core/widgets/custom_input_field.dart';
import 'package:tasti_restaurant_app/core/widgets/image_picker_widget.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_event.dart';
import 'package:tasti_restaurant_app/features/admin/events/presentation/bloc/event_state.dart';

class UpdateEventScreen extends StatefulWidget {
  final EventItem event;

  const UpdateEventScreen({super.key, required this.event});

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _linkController;

  String _pickedImage = '';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.eventTitle);
    _linkController = TextEditingController(text: widget.event.eventLink);
    _pickedImage = widget.event.eventImage;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final link = _linkController.text.trim();
      final image = _pickedImage;

      final parms = UpdateEventParms(
        eventId: widget.event.eventId.toString(),
        title: title,
        link: link,
        image: image,
      );

      context.read<EventBloc>().add(UpdateEvent(parms));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete the form.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Update Event"),
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
                initialImage: _pickedImage,
                onImagePicked: (file) => _pickedImage = file.path,
              ),
              const SizedBox(height: 30),
              BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: _submit,
                    isLoading: state.updateResponse.status == Status.loading,
                    text: "Update Event",
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
