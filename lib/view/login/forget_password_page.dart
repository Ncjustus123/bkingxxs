import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  final passenger = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        width: _width,
        height: _height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        // border: Border.all(width: 0.8, color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Icon(
                          Icons.west,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 90),
                    child: Text("Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  padding: const EdgeInsets.all(23.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                  child: Column(children: [
                    InputFormField(
                      controller: passenger,
                      prefixIcon: Icon(Icons.email_outlined),
                      label: 'Email',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please input a Email address';
                        }
                        return null;
                      },
                    ),
                    InputFormField(
                      controller: password,
                      prefixIcon: Icon(Icons.lock_outline),
                      label: 'Password',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please input a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonReusable(
                      textcolor: Colors.white,
                      name: "Submit",
                      color: Theme.of(context).primaryColor,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
