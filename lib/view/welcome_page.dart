import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/booking/onboarding_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  static final loginPage = "/login";
  static final dashboardPage = "/dashboard";
  static final signUpPage = "/signUpPage";
  UserRepository user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          Container(
            child: Image.asset('images/background.png'),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          Column(
            children: [
              Text("LIBMOT",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              Text("Travel conveniently...",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      fontWeight: FontWeight.w100,
                      fontSize: 11)),
              Spacer(),
              InkWell(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child: Text("Sign In",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),)),
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color:  Theme.of(context).primaryColor, width: 0.7),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(child: Text("Sign Up",style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,),)),
                  ),
                ),
              ),
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
                  user.loginForAndroidIos();
                  Navigator.of(context).pushNamed(dashboardPage);
                },
              ),
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                OnBoardingPage()));
                  },
                  child: Text("southy")),
            ],
          ),
        ],
      ),
    );
  }
}
