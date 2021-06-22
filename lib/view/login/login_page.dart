import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool _passwordVisible = true;
  bool _emailVisible = false;

  final _formKeyLogin = GlobalKey<FormState>();

  final String dashboardPage = "/dashboard";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
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
                padding: const EdgeInsets.only(top: 40, bottom: 90),
                child: Image.asset(
                  "images/LIBMOT LOGO 1.png",
                  height: 55,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25)),
                            ),
                            Text(
                                "Sign in with the registered email and password",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 13)),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: _formPage(user, context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/forget_password");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          "Forgot Password ?",
                                          style: textStyle2,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(65, 15.0, 65, 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text("OR",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("/dashboard");
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Continue as guest",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 13)),
                                    Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.grey,
                                    )
                                  ]),
                            ),
                            SizedBox(height: 70),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("/signUpPage");
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Don't have an account?",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13)),
                                      TextSpan(
                                          text: " Sign Up",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14)),
                                    ])),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formPage(UserRepository user, context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyLogin,
        child: Column(
          children: <Widget>[
            TextFormFeildWidget(
              obscureText: _emailVisible,
              prefixIcon: Icon(Icons.person_outlined, color: Colors.grey),
              controller: emailController,
              lableText: 'Email or Phone Number',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please put in your email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormFeildWidget(
              controller: passwordController,
              obscureText: _passwordVisible,
              lableText: 'Password',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please put in your Password';
                }
                return null;
              },
              prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonReusable(
              onpressed: () async {
                onLoginPressed(user, context);
              },
              name: "Log In",
            ),
            // login(user, context),
          ],
        ),
      ),
    );
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text(" Authenticating ... Please wait")
    ],
  );

  onLoginPressed(UserRepository user, context) async {
    showLoading(
        progressColor: Colors.red,
        indicatorColor: Colors.red,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        indicatorType: EasyLoadingIndicatorType.foldingCube,
        status: "Submitting.....");
    if (_formKeyLogin.currentState.validate()) {
      await user.loginRepo(emailController.text, passwordController.text);
      if (user.loggedInStatus == LoggedInStatus.LoggedIn) {
        Navigator.of(context).pushNamed(dashboardPage);
        EasyLoading.dismiss();
        Dialogs.showSuccessSnackBar('Successful!', "You are welcome back");
      } else {
        print("An errorOccured");
        EasyLoading.dismiss();
        Dialogs.showErrorSnackBar('Oops!', "invalid credential");
      }
    } else {
      print("validation not done");
      // EasyLoading.dismiss();
    }
  }
}
