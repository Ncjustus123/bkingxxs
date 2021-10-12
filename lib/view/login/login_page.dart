import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/services/networking/internet_utils.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/welcome/welcome_page.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// chinedu.nwachukwu@libmot.net
// Acehood12345

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = true;
  bool _emailVisible = false;

  final _formKeyLogin = GlobalKey<FormState>();

  final String dashboardPage = "/dashboard";

  @override
  void initState() {
    getSecureStorage();
    _checkBiometrics();
    super.initState();
  }

  void getSecureStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userStoredEmail = prefs.getString('email');
    final useBiometric = prefs.getString('usingBiometricLogin');
    print(userStoredEmail);
    print(useBiometric);
    setState(() {
      emailController.text = userStoredEmail;
      userStoredBiometric = useBiometric == 'true';
    });
    print(emailController.text);
  }
  bool userStoredBiometric = false;
  bool isUsingBio = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _authenticated;
  bool touchId = false;
  bool _canCheck = false;



  Future<void> _checkBiometrics() async {
    bool canCheck;
    try {
      canCheck = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheck = canCheck;
      print('Biometric state: $_canCheck');
    });
  }
  Future<void> _authenticate() async {
    final user = Provider.of<UserRepository>(context, listen: false);

    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          biometricOnly: true,
          localizedReason: 'Scan your fingerprint to sign in',
          useErrorDialogs: true,
          stickyAuth: true);
      if (authenticated) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userStoredEmail = prefs.getString('email');
        final userStoredPassword = prefs.getString('password');
        setState(() {
          emailController.text = userStoredEmail;
          passwordController.text = userStoredPassword;
        });

        onLoginPressed(user, context);
      }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _authenticated = authenticated;
      print('Biometric: $_authenticated');
    });
  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.red[100].withOpacity(0.2), BlendMode.srcOver),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 90),
                child: Image.asset(
                  "images/LIBMOT LOGO 1.png",
                  height: 55,
                ),
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 7),
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,letterSpacing: 0.8,
                                      fontSize: 25)),
                            ),
                            Text(
                                "Sign in with the registered email and password",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 13)),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: _formPage(user, context),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        
                                         Navigator.of(context)
                                             .pushNamed("/forget_password");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          "Forgot Password ?",
                                          style: textStyle2,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(65, 15.0, 65, 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text("OR",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12)),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                            SizedBox(height: 70),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("/signUpPage");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Don't have an account?",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13)),
                                        TextSpan(
                                            text: " Sign Up",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 14)),
                                      ])),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formPage(UserRepository user, context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKeyLogin,
        child: Column(
          children: <Widget>[
            InputFormField(
              obscure: _emailVisible,
              prefixIcon: Icon(Icons.person_outlined, color: Colors.grey),
              controller: emailController,
              label: 'Email',
              validator: (value) {
                if (value.isEmpty || !value.contains('@')||!value.contains('.')) {
                  return 'Please put in valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            InputFormField(
              controller: passwordController,
              obscure: _passwordVisible,
              label: 'Password',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please put in your Password';
                }
                return null;
              },
              prefixIcon: Icon(Icons.lock_outlined, color: Colors.grey),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonReusable(
              onpressed: () async {
                FocusScope.of(context).unfocus();
                onLoginPressed(user, context);
              },
              name: "Log In",
            ),
            // login(user, context),
          ],
        ),
      ),
    );
  }

  //
  // var loading = Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: <Widget>[
  //
  //     CircularProgressIndicator(),
  //     Text(" Authenticating ... Please wait")
  //   ],
  // );
  //

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


  onLoginPressed(UserRepository user, context) async {
    if (await InternetUtils.checkConnectivity()) {
      if (_formKeyLogin.currentState.validate()) {
        Dialogs.showLoadingDialog(context: context, text: 'SIGNING IN...');
        await user.loginRepo(
            context, emailController.text, passwordController.text);

      } else {
        print("validation not done");
        EasyLoading.dismiss();
      }
    } else
      Dialogs.showNoInternetSnackBar('No Internet Connection',
          'Check your internet connection and try again.');
  }


}


class LoginAnim extends StatefulWidget {
  @override
  _LoginAnimState createState() => _LoginAnimState();
}

class _LoginAnimState extends State<LoginAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(() => DashboardPage());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.red[100].withOpacity(0.2), BlendMode.srcOver),
        ),
      ),
      child: Column(
        children: [
          Spacer(),
          Text("LIBMOT",
              style: GoogleFonts.libreBaskerville(
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
          SlideTransition(
              position: _offsetAnimation,
              child: Image.asset('images/haice_2020.png')),
          SizedBox(height: 80),
        ],
      ),
    ));
  }
}
