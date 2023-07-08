import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

pickerimage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  Get.snackbar('Alert', "No image was selected",
      snackPosition: SnackPosition.BOTTOM);
}
