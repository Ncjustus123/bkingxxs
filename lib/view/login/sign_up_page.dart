import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firstNamecontroller = TextEditingController();
  final lastNamecontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final referralcontroller = TextEditingController();
  bool _passwordVisible = true;
  UserRepository userRepository;
  int gender;
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.red[100].withOpacity(0.2), BlendMode.srcOver),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 50),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: _formPage(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formPage() {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyLogin,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            TextFormFeildWidget(
              obscureText: false,
              controller: firstNamecontroller,
              lableText: 'First Name',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please input your Firstname';
                }
                return null;
              },
            ),
            TextFormFeildWidget(
              controller: lastNamecontroller,
              obscureText: false,
              lableText: 'Last Name',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please input your Lastname';
                }
                return null;
              },
            ),
            TextFormFeildWidget(
              controller: emailcontroller,
              lableText: "Email",
              obscureText: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please input an email';
                }
                return null;
              },
            ),
            TextFormFeildWidget(
              lableText: "Gender",
              obscureText: false,
              controller: gendercontroller,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please input gender';
                }
                return null;
              },
            ),
            TextFormFeildWidget(
              obscureText: false,
              lableText: "Phone number",
              controller: phoneNumbercontroller,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please input a phone number';
                }
                return null;
              },
            ),
            TextFormFeildWidget(
              controller: passwordcontroller,
              obscureText: _passwordVisible,
              lableText: 'Password',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please put in your Password';
                }
                return null;
              },
              prefixIcon: Icon(Icons.lock, color: Colors.grey),
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
            TextFormFeildWidget(
              obscureText: false,
              controller: referralcontroller,
              lableText: "Referal link",
            ),
            SizedBox(height: 20,),
            ButtonReusable(
              name: "Sign Up",
            ),
          ],
        ),
      ),
    );
  }
}
