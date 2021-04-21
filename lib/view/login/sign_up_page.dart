

import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

final firstNamecontroller = TextEditingController();
final lastNamecontroller = TextEditingController();
final gendercontroller = TextEditingController();
final emailcontroller = TextEditingController();
final phoneNumbercontroller = TextEditingController();
final passwordcontroller = TextEditingController();
final referralcontroller = TextEditingController();
bool _passwordVisible = true;
UserRepository userRepository;

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    userRepository = Provider.of<UserRepository>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Text("create an account"),
          firstNameField(),
          lastNameField(),
          emailField(),
          genderField(),
          phoneNumberField(),
          passwordField(),
          referalField(),
          Spacer(),
          signUpButton(),
          Spacer(),
        ]),
      ),
    );
  }

  ButtonTheme signUpButton() {
    return ButtonTheme(
          height: 50,
          minWidth: 200,
          child: ElevatedButton(
            child: Text("Sign up"),
            onPressed: () {
              userRepository.signUp.firstName=firstNamecontroller.text;
              userRepository.signUp.lastName=lastNamecontroller.text;
              userRepository.signUp.email=emailcontroller.text;
              userRepository.signUp.phoneNumber=phoneNumbercontroller.text;
              userRepository.signUp.referralCode=referralcontroller.text;
              userRepository.signUp.password=passwordcontroller.text;
              userRepository.signUp.gender = (gendercontroller.text == "male")?0:1;
            },
          ),
        );
  }

  firstNameField() {
    return TextFormField(
      controller: firstNamecontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a name';
        }
        return null;
      },
    );
  }

  lastNameField() {
    return TextFormField(
      controller: lastNamecontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a name';
        }
        return null;
      },
    );
  }

  emailField() {
    return TextFormField(
      controller: emailcontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input an email';
        }
        return null;
      },
    );
  }
 int gender;
  genderField() {
    return TextFormField(
      controller: gendercontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input gender';
        }
        
        return null;
      },
      onTap: (){},
    );
  }

  phoneNumberField() {
    return TextFormField(
      controller: phoneNumbercontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a phone number';
        }
        return null;
      },
    );
  }

  passwordField() {
    return TextFormField(
      controller: passwordcontroller,
      obscureText: _passwordVisible,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a password';
        }
        return null;
      },
    );
  }

  referalField() {
    return TextFormField(
      controller: referralcontroller,
    );
  }
}
