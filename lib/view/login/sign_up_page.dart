import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
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
      // backgroundColor: Colors.black12,
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
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Text(
                "Create An Account",
                style: textStyle1,
              ),
              firstNameField(),
              lastNameField(),
              emailField(),
              genderField(),
              phoneNumberField(),
              passwordField(),
              referalField(),
              ButtonClass(
                side: BorderSide.none,
                color: Colors.red,
                title: Text('Create Account'),
                onpressed: () {
                  userRepository.signUp.firstName = firstNamecontroller.text;
                  userRepository.signUp.lastName = lastNamecontroller.text;
                  userRepository.signUp.email = emailcontroller.text;
                  userRepository.signUp.phoneNumber =
                      phoneNumbercontroller.text;
                  userRepository.signUp.referralCode =
                      (referralcontroller.text.isEmpty)
                          ? null
                          : referralcontroller.text;
                  userRepository.signUp.password = passwordcontroller.text;
                  userRepository.signUp.gender =
                      (gendercontroller.text == "male") ? 0 : 1;
                  userRepository.signUpCustomer(context);
                },
              ),
              SizedBox(
                height: 10,
              ),
              ButtonClass(
                onpressed: () {
                  Navigator.of(context).pushNamed("/login");
                },
                title: Text("Log In"),
                color: Colors.transparent,
                side: BorderSide(
                  width: 1.0,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/dashboard");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue As Guest",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                     Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ]),
          ),
        ),
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
      //onTap: () {},
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
      margin: EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            controller: passwordcontroller,
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              fillColor: Colors.grey,
              focusColor: Colors.grey,
              border: InputBorder.none,
              labelText: "Password",
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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

