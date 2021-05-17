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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Text("Sign in to your account",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10)),
            Center(
              child: _formPage(user, context),
            ),
            Text("Dont have an account? Sign up here.",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10)),
            SizedBox(
              height: 20,
            ),
            Text("OR",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10)),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Continue as guest",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 10)),
              Icon(Icons.arrow_forward),
            ]),
          ],
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
          login(user, context),
        ],
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person, color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey)),
              labelText: 'Email or Phone Number',
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
    );
  }

  Widget passwordField() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey)),
              labelText: 'Password',
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              labelStyle: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }

  Widget login(UserRepository user, context) {
    return ElevatedButton(
      child: Text("Submit"),
      onPressed: () => onLoginPressed(user, context),
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
