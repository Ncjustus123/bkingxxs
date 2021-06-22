import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration:Duration(seconds: 4),

      icon: Icon(
        Icons.emoji_emotions,
        color: Colors.red,
      ),
      backgroundColor: Color(0xFF0F0F0F).withOpacity(0.7),
      colorText: Colors.white,
    );
  }

  static showSuccessSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration:Duration(seconds: 4),

      icon: Icon(
        Icons.emoji_emotions,
        color: Colors.green,
      ),
      backgroundColor: Color(0xFF0F0F0F).withOpacity(0.5),
      colorText: Colors.white,
    );
  }
}
