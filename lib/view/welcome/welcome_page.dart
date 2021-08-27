import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/services/networking/internet_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  void initState() {


    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              children: [
                Spacer(flex: 1),
                Stack(
                  children: [
                    Text("LIBMOT",
                        style: GoogleFonts.signika(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 65)),
                    Positioned(
                      bottom: 0,
                      right:0,
                      child: Text(" Travel conveniently...  ",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                    ),
                  ],
                ),
                Spacer(flex: 2),
                Buttons.coloredButton(
                  context: context,
                  title: 'Sign In',
                  onTap: () {
                    Navigator.of(context).pushNamed(WelcomePage.loginPage);
                  },
                ),
                SizedBox(height: 30),
                Buttons.whiteButton(
                  context: context,
                  title: 'Sign Up',
                  onTap: () {
                    Navigator.of(context).pushNamed(WelcomePage.signUpPage);
                  },
                ),
                SizedBox(height: 37),
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
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
    if (await InternetUtils.checkConnectivity()) {
      setState(() {
        isLoadingGuest = true;
      });
      user.loginForAndroidIos(context);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(WelcomePage.dashboardPage, (route) => false);
      Dialogs.showWelcomeSnackBar(
          'You are welcome to LIBMOT', "Travel conveniently...");
    } else {
      Dialogs.showNoInternetSnackBar('No Internet Connection',
          'Check your internet connection and try again.');
    }
  }
}
