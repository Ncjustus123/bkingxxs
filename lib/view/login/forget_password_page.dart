import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:flutter/material.dart';

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
            myAppBar(context,"Forgot Password"),
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
