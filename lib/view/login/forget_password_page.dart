import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final passenger = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xFFFFFFFF).withOpacity(0.9), BlendMode.srcOver),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 40, top: 30),
                child: Image.asset(
                  "images/LIBMOT LOGO 1.png",
                  height: 55,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              emailField(),
              passwordField(),
              SizedBox(
                height: 20,
              ),
              ButtonReusable(
                name:"Submit" ,
              ),
              // ButtonClass(
              //   color: Colors.red,
              //   side: BorderSide.none,
              //   title: Text(
              //     "Submit",
              //     style: textStyle,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  emailField() {
    return WidgetTextField(
      controller: passenger,
      lableText: "Email",
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a Email address';
        }
        return null;
      },
    );
  }

  passwordField() {
    return WidgetTextField(
      controller: password,
      lableText: "Password",
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a password';
        }
        return null;
      },
    );
  }
}
