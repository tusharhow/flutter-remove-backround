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
          GestureDetector(
            onTap: () {
              controller.pickImage(ImageSource.camera);
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(Icons.camera),
                SizedBox(
                  width: 5,
                ),
                Text("Camera"),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              controller.pickImage(ImageSource.gallery);
              Navigator.pop(context);
            },
            child: Row(
              children: const [
                Icon(Icons.image),
                SizedBox(
                  width: 5,
                ),
                Text("Gallery"),
              ],
            ),
          ),
        ])
      ],
    ),
  );
}
