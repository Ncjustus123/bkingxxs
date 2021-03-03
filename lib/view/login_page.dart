import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKeyLogin = GlobalKey<FormState>();
  final String dashboardPage = "/dashboard";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Scaffold(
        body: SafeArea(child: Center(child: _formPage(user, context))));
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
    return TextFormField(
        //key: _formKeyLogin,
        controller: emailController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please put in your email';
          }
          return null;
        });
  }

  Widget passwordField() {
    return TextFormField(
        controller: passwordController,
        // key: _formKeyLogin,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please put in your email';
          }
          return null;
        });
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
