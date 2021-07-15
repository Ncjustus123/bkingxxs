import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/repository/user_repository.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:Libmot_Mobile/view/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../internet_utils.dart';

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
    if (await InternetUtils.checkConnectivity()) {
      user.checkLogin(context);
    } else {

      Get.to(()=>WelcomePage());
      noNetworkDialog(title:'Oops!', content: 'You seem not to be connected to the internet.',onPressed:(){Get.offAll(()=>InitialPage());});

    }
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
    //   Get.offAll(() => OnBoardingPage());}
  }

  Future noNetworkDialog({title, content, onPressed}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          height: 350,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Icon(
                  Icons.wifi_off,
                  color: Colors.blueGrey.withOpacity(0.4),
                  size: 90,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24,color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  content,
                  style: TextStyle(fontSize: 15,color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                SmallButtonReusable(name: "Retry", onpressed: onPressed),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<UserRepository>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        child: Center(child: Image.asset('images/LIBMOT LOGO 1.png',height: 100,)),
      ),
    );
  }

// @override
// void afterFirstLayout(BuildContext context) {
//   user.checkLogin(context);
// // }
}
