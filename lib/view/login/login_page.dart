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
              Text("Sign in to your account",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10)),
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
                padding: const EdgeInsets.only(right: 0,left: 150),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed("/forget_password");
                  },
                  child: Text("Forgot Password ?",style: textStyle2,)),
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
              Text("----OR----",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/dashboard");
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Continue as guest",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.grey,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formPage(UserRepository user, context) {
    return Form(
      key: _formKeyLogin,
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          SizedBox(height: 10,),
          login(user, context),
        ],
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Email or Phone Number',
                labelStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              ),
              //key: _formKeyLogin,
              controller: emailController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please put in your email';
                }
                return null;
              }),
        ),
      ),
    );
  }

  Widget passwordField() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            controller: passwordController,
            obscureText: _passwordVisible,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please put in your email';
              }
              return null;
            },
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
                prefixIcon: Icon(Icons.lock, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Password',
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                labelStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ),
    );
  }

  Widget login(UserRepository user, context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: Text("Log In"),
        onPressed: () => onLoginPressed(user, context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
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
