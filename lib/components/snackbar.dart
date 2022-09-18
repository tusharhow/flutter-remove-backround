import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String message,bool isError) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.red : Colors.green,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    borderWidth: 1,
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(seconds: 2),
    colorText: Colors.white,
  );
}