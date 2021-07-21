import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/services/networking/internet_utils.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';

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
  Animation<double> _animation;
  UserRepository user;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1700), vsync: this);
    _animation = Tween<double>(begin: 40, end: 300).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
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
                Spacer(),
                SizedBox(
                  width: 250.0,
                  height: 50,
                  child: Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: Colors.red,
                      ),
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        pause: Duration(milliseconds: 500),
                        animatedTexts: [
                          ScaleAnimatedText('Travel'),
                          ScaleAnimatedText('conveniently'),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: _animation.value,
                //   width: _animation.value,
                //   child: Text("LIBMOT",
                //       style: GoogleFonts.libreBaskerville(
                //           color: Colors.red,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 50)),
                // ),
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
                SizedBox(height: 30),
                Buttons.whiteButton(
                  context: context,
                  title: 'Sign Up',
                  onTap: () {
                    Navigator.of(context).pushNamed(WelcomePage.signUpPage);
                  },
                ),
                SizedBox(
                  height: 35,
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
