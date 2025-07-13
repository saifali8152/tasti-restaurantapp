import 'package:image_picker/image_picker.dart';

class PickerServices {
  final ImagePicker picker = ImagePicker();

  Future<XFile?> galleryImage() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> cameraImage() async {
    return await picker.pickImage(source: ImageSource.camera);
  }
}
