
import 'package:Libmot_Mobile/view/booking/onboarding_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static final loginPage = "/login";
  static final dashboardPage = "/dashboard";
  static final signUpPage = "/signUpPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Welcome",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30)),
              Spacer(),
              ElevatedButton(
                child: Text("SignIn"),
                onPressed: () {
                  Navigator.of(context).pushNamed(loginPage);
                },
              ),
              ElevatedButton(
                child: Text("SignUp"),
                onPressed: () {
                  Navigator.of(context).pushNamed(signUpPage);
                },
              ),
              ElevatedButton(
                child: Text("Continue as guest"),
                onPressed: () {
                  Navigator.of(context).pushNamed(dashboardPage);
                },
              ),
              RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardingPage()));
                },
                child:Text("southy")
                ),
            ],
          ),
        ),
      ),
    );
  }
}
