import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class RemoveBgController extends GetxController {
  Uint8List? imageFile;
  String? imagePath;
  ScreenshotController controller = ScreenshotController();
  var isLoading = false.obs;

  Future<Uint8List> removeBg(String imagePath) async {
    isLoading = true.obs;
    update();
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": "XH5axMWfLx5SSxSFLqEvJcMA"});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      isLoading = false.obs;
      update();
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error");
    }
  }

  void pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFile = await pickedImage.readAsBytes();
        update();
      }
    } catch (e) {
      imageFile = null;
      update();
    }
  }

// clean up the image file after it is used
  void cleanUp() {
    imageFile = null;
    update();
  }

  void saveImage() async {
    bool isGranted = await Permission.storage.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.storage.request().isGranted;
    }
    if (isGranted) {
      String directory = (await getExternalStorageDirectory())!.path;
      String fileName = "${DateTime.now().microsecondsSinceEpoch}.png";
      controller.captureAndSave(directory, fileName: fileName);
    }
  }
}
