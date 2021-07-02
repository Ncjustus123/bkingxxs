import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/onboarding_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/utils.dart';

class WelcomePage extends StatefulWidget {
  static final loginPage = "/login";
  static final dashboardPage = "/dashboard";
  static final signUpPage = "/signUpPage";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  UserRepository user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: Image.asset('images/background.png', fit: BoxFit.fill),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              children: [
                Spacer(),
                Text("LIBMOT",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 50)),
                Text("Travel conveniently...",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w100,
                        fontSize: 12)),
                Spacer(),
                Buttons.coloredButton(
                  context: context,
                  title: 'Sign In',
                  onTap: () {
                    Navigator.of(context).pushNamed(WelcomePage.loginPage);
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Buttons.whiteButton(
                  context: context,
                  title: 'Sign Up',
                  onTap: () {
                    Navigator.of(context).pushNamed(WelcomePage.signUpPage);
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                isLoadingGuest
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: () {
                          loginForAndroidIos(user);
                        },
                        child: Center(
                          child: Text(
                            "Continue as guest",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        // onTap: () {
                        //   user.loginForAndroidIos();
                        //   Navigator.of(context).pushNamed(WelcomePage.dashboardPage);

                        // },
                      ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isLoadingGuest = false;

  changeGuestLoading() {
    setState(() {
      isLoadingGuest = !isLoadingGuest;
    });
  }

  loginForAndroidIos(user) async {
    setState(() {
      isLoadingGuest = true;
    });
    user.loginForAndroidIos(context);
    Navigator.of(context).pushNamedAndRemoveUntil(WelcomePage.dashboardPage, (route) => false);
    Dialogs.showWelcomeSnackBar('You are welcome to LIBMOT', "Travel conveniently...");
  }
}
