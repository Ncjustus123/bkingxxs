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
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text("create an account"),
            firstNameField(),
            SizedBox(height: 10),
            lastNameField(),
            SizedBox(height: 10),
            emailField(),
            SizedBox(height: 10),
            genderField(),
            SizedBox(height: 10),
            phoneNumberField(),
            SizedBox(height: 10),
            passwordField(),
            SizedBox(height: 10),
            referalField(),
            SizedBox(height: 20),
            signUpButton(),
            SizedBox(height: 10),
            Text(
              "i have an account. Sign in here",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Spacer(),
          ]),
        ),
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
          userRepository.signUp.firstName = firstNamecontroller.text;
          userRepository.signUp.lastName = lastNamecontroller.text;
          userRepository.signUp.email = emailcontroller.text;
          userRepository.signUp.phoneNumber = phoneNumbercontroller.text;
          userRepository.signUp.referralCode = referralcontroller.text;
          userRepository.signUp.password = passwordcontroller.text;
          userRepository.signUp.gender =
              (gendercontroller.text == "male") ? 0 : 1;
        },
      ),
    );
  }

  firstNameField() {
    return WidgetTextField(
      controller: firstNamecontroller,
      lableText: "First Name",
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input your Firstname';
        }
        return null;
      },
    );
  }

  lastNameField() {
    return WidgetTextField(
      lableText: "Last Name",
      controller: lastNamecontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input your Lastname';
        }
        return null;
      },
    );
  }

  emailField() {
    return WidgetTextField(
      lableText: "Email",
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
    return WidgetTextField(
      lableText: "Gender",
      controller: gendercontroller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input gender';
        }

        return null;
      },
      onTap: () {},
    );
  }

  phoneNumberField() {
    return WidgetTextField(
      lableText: "Phone number",
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          controller: passwordcontroller,
          obscureText: _passwordVisible,
          decoration: InputDecoration(
            fillColor: Colors.grey,
            focusColor: Colors.grey,
            border: InputBorder.none,
            labelText: "Password",
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
        ),
      ),
    );
  }

  referalField() {
    return WidgetTextField(
      controller: referralcontroller,
      lableText: "Referal link",
    );
  }
}

class WidgetTextField extends StatelessWidget {
  final String lableText;
  final Function validator;
  final controller;
  final Function onTap;
  const WidgetTextField(
      {Key key,
      @required this.lableText,
      this.validator,
      @required this.controller,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          onTap: onTap,
          decoration: InputDecoration(
            fillColor: Colors.grey,
            focusColor: Colors.grey,
            border: InputBorder.none,
            labelText: lableText,
          ),
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}
