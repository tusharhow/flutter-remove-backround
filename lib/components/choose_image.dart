import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
