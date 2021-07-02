import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static showErrorSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      duration: Duration(seconds: 4),
      icon: Icon(
        Icons.emoji_emotions,
        color: Colors.red,
      ),
      backgroundColor: Colors.redAccent.withOpacity(0.7),
      colorText: Colors.white,
    );
  }

  static showSuccessSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      borderRadius: 5,
      duration: Duration(seconds: 4),
      icon: Image.asset(
        'images/LIBMOT LOGO 1.png',
        width: 50,
      ),
      backgroundColor: Colors.white,
      colorText: Colors.blueGrey,
    );
  }

  static showWelcomeSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      borderRadius: 5,
      duration: Duration(seconds: 4),
      icon: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.redAccent.withOpacity(0.3)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.asset(
                'images/LIBMOT LOGO 1.png',
                width: 75,
                height: 75,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      colorText: Colors.blueGrey,
    );
  }
}
