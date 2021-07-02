import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/resources/database/user_preference.dart';
import 'package:Libmot_Mobile/view/onboarding_page.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:Libmot_Mobile/view/widgets/dashBoard_screen.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard_page.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  // with AfterLayoutMixin<InitialPage> {
  UserRepository user;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      getSecureStorage();
    });
    super.initState();
  }

  void getSecureStorage() async {
      user.checkLogin(context);

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // final newUser = prefs.getString('isNewUser');
    // final preference = await UserPreference.getInstance();
    // bool loggedIn = preference.isLoggedIn() ?? false;
    // print(newUser);
    // print(loggedIn);
    // if (newUser == 'No') {
    //   var _loggedInStatus = LoggedInStatus.Unknown;
    //
    //   if (loggedIn) {
    //     _loggedInStatus = LoggedInStatus.LoggedIn;
    //     Get.offAll(() => DashboardPage());
    //
    //     // Navigator.of(context).pushNamed(dashboardRoute);
    //   } else {
    //     _loggedInStatus = LoggedInStatus.LoggedOut;
    //     Get.offAll(() => WelcomePage());
    //
    //     // Navigator.of(context).pushNamed(welcomeRoute);
    //   }
    // } else
    //   Get.offAll(() => OnBoardingPage());
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);

    return Scaffold(
      backgroundColor: Color(0xFFB8230B),
      body: GestureDetector(
        onTap: () {
          Get.to(() => OnBoardingPage());
        },
        child: Container(
          color: Color(0xFFB8230B),
          child: Center(
              child: Image.asset(
            'images/LIBMOT LOGO 1.png',
            width: MediaQuery.of(context).size.width * 0.6,
          )),
        ),
      ),
    );
  }

// @override
// void afterFirstLayout(BuildContext context) {
//   user.checkLogin(context);
// // }
}
