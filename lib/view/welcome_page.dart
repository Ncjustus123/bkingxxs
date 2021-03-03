import 'package:Libmot_Mobile/view/dashboard_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static final loginPage = "/login";
  static final dashboardPage = "/dashboard";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                child: Text("Login"),
                onPressed: () {
                  Navigator.of(context).pushNamed(loginPage);
                },
              ),
              ElevatedButton(
                child: Text("Registration"),
                onPressed: () {
                  Navigator.of(context).pushNamed(loginPage);
                },
              ),
              ElevatedButton(
                child: Text("Continue as guest"),
                onPressed: () {
                  Navigator.of(context).pushNamed(dashboardPage);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
