import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:flutter/material.dart';
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
      // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.red[100].withOpacity(0.2), BlendMode.srcOver),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 90),
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
                  child: Column(
                    children: [
                      Text("Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 40)),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: _formPage(user, context),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 0, left: 150),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("/forget_password");
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: textStyle2,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          child: Text("Create Account"),
                          onPressed: () {
                            Navigator.of(context).pushNamed("/signUpPage");
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50,15.0,50,15),
                        child: Row(children: [
                          Expanded(child: Container(color: Colors.grey,height: 1,),),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("OR",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12)),
                          ),
                          Expanded(child: Container(color: Colors.grey,height: 1,),),
                        ],),
                      ),

                      SizedBox(
                        height: 20,
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
                                      fontSize: 14)),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ]),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("/signUpPage");
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(text: TextSpan(children: [
                                TextSpan(text:"Don't have an account?",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13) ),
                                TextSpan(text:" Sign Up",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15) ),
                              ])),


                            ]),
                      ),
                    ],
                  )),
            ),
          ],
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
            SizedBox(
              height: 10,
            ),
            ButtonReusable(onpressed:()async {onLoginPressed(user, context);},name: "Log In",),
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
    if (_formKeyLogin.currentState.validate()) {
      await user.loginRepo(emailController.text, passwordController.text);
      if (user.loggedInStatus == LoggedInStatus.LoggedIn) {
        Navigator.of(context).pushNamed(dashboardPage);
      } else {
        print("An errorOccured");
      }
    } else {
      print("validation not done");
    }
  }
}
