
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:Libmot_Mobile/services/networking/internet_utils.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/view/welcome/welcome_page.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
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
    super.initState();
  }


  void getSecureStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userStoredEmail = prefs.getString('email');
    setState(() {
      emailController.text = userStoredEmail;
    });
    print(emailController.text);
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
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
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
                                : InkWell(
                                    onTap: () {
                                      loginForAndroidIos(user);
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Continue as guest",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13)),
                                          Icon(
                                            Icons.arrow_right_alt,
                                            color: Colors.grey,
                                          )
                                        ]),
                                  ),
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
                                                color: Colors.black,
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
            TextFormFeildWidget(
              obscureText: _emailVisible,
              prefixIcon: Icon(Icons.person_outlined, color: Colors.grey),
              controller: emailController,
              lableText: 'Email or Phone Number',
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please put in your email';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormFeildWidget(
              controller: passwordController,
              obscureText: _passwordVisible,
              lableText: 'Password',
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
if(await InternetUtils.checkConnectivity()) {
  setState(() {
    isLoadingGuest = true;
  });
  user.loginForAndroidIos(context);
  Navigator.of(context).pushNamedAndRemoveUntil(
      WelcomePage.dashboardPage, (route) => false);
  Dialogs.showWelcomeSnackBar(
      'You are welcome to LIBMOT', "Travel conveniently...");
}else{

  Dialogs.showNoInternetSnackBar('No Internet Connection',
      'Check your internet connection and try again.');
}

  }

  onLoginPressed(UserRepository user, context) async {
    if (await InternetUtils.checkConnectivity()) {
      showLoading(
          progressColor: Colors.red,
          indicatorColor: Colors.red,
          backgroundColor: Colors.white,
          textColor: Colors.red,
          indicatorType: EasyLoadingIndicatorType.foldingCube,
          status: "\nLogin in.....");
      if (_formKeyLogin.currentState.validate()) {
        await user.loginRepo(
            context, emailController.text, passwordController.text);
        if (user.loggedInStatus == LoggedInStatus.LoggedIn) {
          // Navigator.of(context).pushNamed(dashboardPage);
          Get.offAll(()=>DashboardPage());
          EasyLoading.dismiss();
          Dialogs.showWelcomeSnackBar('Successful!', "You are welcome back");
        } else {
          print("An errorOccurred");
          EasyLoading.dismiss();
        }
      } else {
        print("validation not done");
        // EasyLoading.dismiss();
      }
    } else

      Dialogs.showNoInternetSnackBar('No Internet Connection',
          'Check your internet connection and try again.');
  }
}
