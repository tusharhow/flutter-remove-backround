// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import '../components/primary_button.dart';
import '../controllers/remove_bg_controller.dart';

class RemoveBackroundScreen extends StatelessWidget {
  const RemoveBackroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: const Text('Remove Background'),
        ),
        body: Center(
          child: GetBuilder<RemoveBgController>(
              init: RemoveBgController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (controller.imageFile != null)
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Screenshot(
                                  controller: controller.controller,
                                  child: Image.memory(
                                    controller.imageFile!,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              ReusablePrimaryButton(
                                  childText: "Remove Background",
                                  textColor: Colors.white,
                                  buttonColor: Colors.deepPurpleAccent,
                                  onPressed: () async {
                                    if (controller.imageFile == null) {
                                      Get.snackbar(
                                        "Error",
                                        "Please select an image",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.red,
                                        borderRadius: 10,
                                        margin: const EdgeInsets.all(10),
                                        borderColor: Colors.red,
                                        borderWidth: 2,
                                        duration: const Duration(seconds: 2),
                                        icon: const Icon(Icons.error),
                                      );
                                    } else {
                                      controller.imageFile =
                                          await RemoveBgController()
                                              .removeBgApi(
                                                  controller.imagePath!);
                                      print("Success");
                                    }
                                    controller.update();
                                  }),
                              const SizedBox(height: 20),
                              ReusablePrimaryButton(
                                  childText: "Save Image",
                                  textColor: Colors.white,
                                  buttonColor: Colors.deepPurpleAccent,
                                  onPressed: () async {
                                    if (controller.imageFile != null) {
                                      controller.saveImage();

                                      Get.snackbar(
                                        "Success",
                                        "Image saved successfully",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.green,
                                        borderRadius: 10,
                                        margin: const EdgeInsets.all(10),
                                        borderColor: Colors.green,
                                        borderWidth: 2,
                                        duration: const Duration(seconds: 2),
                                        icon: const Icon(Icons.check),
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Error",
                                        "Please select an image",
                                        colorText: Colors.white,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Colors.red,
                                        borderRadius: 10,
                                        margin: const EdgeInsets.all(10),
                                        borderColor: Colors.red,
                                        borderWidth: 2,
                                        duration: const Duration(seconds: 2),
                                        icon: const Icon(Icons.error),
                                      );
                                    }
                                  }),
                              const SizedBox(height: 20),
                              ReusablePrimaryButton(
                                  childText: "Add New Image",
                                  textColor: Colors.white,
                                  buttonColor: Colors.deepPurpleAccent,
                                  onPressed: () async {
                                    controller.cleanUp();
                                  }),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.image,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 40),
                              ReusablePrimaryButton(
                                  childText: "Select Image",
                                  textColor: Colors.white,
                                  buttonColor: Colors.deepPurpleAccent,
                                  onPressed: () async {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return bottomSheet(
                                              controller, context);
                                        });
                                  }),
                            ],
                          ),
                  ],
                );
              }),
        ));
  }
}

Widget bottomSheet(controller, context) {
  return Container(
    height: 100.0,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        const Text(
          "Choose an image",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children:[
          FlatButton.icon(
            icon: const Icon(Icons.camera),
            onPressed: () {
              controller.pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
            label: const Text("Camera"),
          ),
          FlatButton.icon(
            icon: const Icon(Icons.image),
            onPressed: () {
              controller.pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
            label: const Text("Gallery"),
          ),
        ])
      ],
    ),
  );
}
