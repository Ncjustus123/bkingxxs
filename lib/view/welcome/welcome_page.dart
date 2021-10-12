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

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  UserRepository user;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1700), vsync: this);

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              color: Colors.grey.withOpacity(0.6),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              children: [
                Spacer(flex: 1),
                // SizedBox(
                //   width: 250.0,
                //   height: 50,
                //   child: Center(
                //     child: DefaultTextStyle(
                //       style: const TextStyle(
                //         fontSize: 17.0,
                //         color: Colors.red,
                //       ),
                //       child: AnimatedTextKit(
                //         totalRepeatCount: 1,
                //         pause: Duration(milliseconds: 500),
                //         animatedTexts: [
                //           ScaleAnimatedText('Travel'),
                //           ScaleAnimatedText('conveniently'),
                //         ],
                //         onTap: () {
                //           print("Tap Event");
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                Text("LIBMOT",
                    style: GoogleFonts.archivo(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 50)),
                //
                Text("Travel conveniently...",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w100,
                        fontSize: 14)),
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
                    : FlatButton(
                    onPressed: (){
                      loginForAndroidIos(user);
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text("Continue as Guest",)),

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
