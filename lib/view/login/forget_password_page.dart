import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final passenger = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Column(
          children: [
            emailField(),
            passwordField(),
          ],
        ),
      ),
    );
  }

  emailField() {
    return TextFormField(
      controller: passenger,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  passwordField() {
    return TextFormField(
      controller: password,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }
}
