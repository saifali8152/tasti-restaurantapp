import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/services/session_controller.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_input_field.dart';
import '/core/widgets/field_label.dart';
import '/core/widgets/image_picker_widget.dart';
import '/features/restaurant-admin/gallery/presentation/bloc/gallery_bloc.dart';
import '/features/restaurant-admin/gallery/presentation/bloc/gallery_event.dart';
import '/features/restaurant-admin/gallery/presentation/bloc/gallery_state.dart';
import '../../../../../core/widgets/custom_button.dart';
import '/core/widgets/custom_app_bar.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  String image = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Photos',
      ),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldLabel(title: "Food Name"),
                CustomInputField(
                    hintText: "Enter Food Name", controller: nameC),
                SizedBox(height: 10),
                FieldLabel(title: "Food Description"),
                CustomInputField(
                  hintText: "Enter Food Description",
                  controller: descriptionC,
                ),
                SizedBox(height: 10),
                Text("Choose Image",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ImagePickerWidget(onImagePicked: (img) => image = img.path),
                const SizedBox(height: 20),
                BlocConsumer<GalleryBloc, GalleryState>(
                  bloc: context.read<GalleryBloc>(),
                  listener: (context, state) {
                    if (state.addResponse.status == Status.error) {
                      context.flushBarErrorMessage(
                          message: state.addResponse.message.toString());
                    }
                    if (state.addResponse.status == Status.completed) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        if (image.isEmpty) {
                          context.flushBarErrorMessage(
                              message: "Image is required");
                        } else if (_formKey.currentState!.validate()) {
                          context.read<GalleryBloc>().add(AddGalleryEvent(
                                AddGalleryParms(
                                  id: SessionController().user?.restaurant.id,
                                  name: nameC.text,
                                  notes: descriptionC.text,
                                  image: image,
                                ),
                              ));
                        }
                      },
                      text: "Upload",
                      isLoading: state.addResponse.status == Status.loading,
                      bgColor: Colors.red,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
