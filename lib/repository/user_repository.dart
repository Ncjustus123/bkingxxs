import 'dart:convert';
import 'dart:io';

import 'package:Libmot_Mobile/models/get_token_model.dart';
import 'package:Libmot_Mobile/models/profile_model.dart';
import 'package:Libmot_Mobile/models/sign_up_model.dart';
import 'package:Libmot_Mobile/resources/database/user_preference.dart';
import 'package:Libmot_Mobile/view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/onboarding_page.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';
import 'package:Libmot_Mobile/view/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as route;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/networking/api_calls.dart';

//final signUp = new SignUpCustomersObject();
final String welcomeRoute = "/welcome";
final String dashboardRoute = "/dashboard";
enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
  Error
}
enum LoggedInStatus { LoggedIn, LoggedOut, Unknown }

class UserRepository with ChangeNotifier {
  var _loggedInStatus = LoggedInStatus.Unknown;
  var _status = Status.NotLoggedIn;
  final _api = ApiCalls();
  Profile profile;
  SignUpCustomersObject signUp = new SignUpCustomersObject();
  SignUpCustomers signedUpCustomers;
  TextEditingController otp = TextEditingController();

  Status get status => _status;

  LoggedInStatus get loggedInStatus => _loggedInStatus;

  checkLogin(BuildContext context) async {
    final preference = await UserPreference.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool loggedIn = preference.isLoggedIn() ?? false;
    final newUser = prefs.getString('isNewUser');

    if (newUser == 'No') {

      if (loggedIn) {
        _loggedInStatus = LoggedInStatus.LoggedIn;
        route.Get.offAll(() => DashboardPage());

        // Navigator.of(context).pushNamed(dashboardRoute);
      } else {
        _loggedInStatus = LoggedInStatus.LoggedOut;
        route.Get.offAll(() => WelcomePage());

        // Navigator.of(context).pushNamed(welcomeRoute);
      }
    } else
      route.Get.offAll(() => OnBoardingPage());


    // if (loggedIn) {
    //   _loggedInStatus = LoggedInStatus.LoggedIn;
    //   Navigator.of(context).pushNamed(dashboardRoute);
    // } else {
    //   _loggedInStatus = LoggedInStatus.LoggedOut;
    //   Navigator.of(context).pushNamed(welcomeRoute);
    // }
  }

  logout() async {
    final pref = await UserPreference.getInstance();
    pref.deleteProfile();
    _loggedInStatus = LoggedInStatus.LoggedOut;
    notifyListeners();
  }

  loginRepo(context, String email, String password) async {
    // _status = Status.Authenticating;
    // notifyListeners();
print('$email $password');
    final response = await _api.login(email, password);
    print('response');
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      GetTokenResponse tokenData = GetTokenResponse.fromJson(responseData);

      if (tokenData.code == "200") {
        final preference = await UserPreference.getInstance();
        preference.saveToken(tokenData);
        preference.saveLogin(email);
        profile = await getProfile(tokenData.object.token);
        preference.setLoggedInState(true);
        preference.saveProfile(profile);
        loginForAndroidIos(context);
        _loggedInStatus = LoggedInStatus.LoggedIn;
        notifyListeners();
      } else {
        print('error');
        print('${tokenData.shortDescription}');
        Dialogs.showErrorSnackBar('Oops!', "${tokenData.shortDescription}");
        if ("${tokenData.shortDescription}" ==
            "Account not active. Please activate your acccount to continue.") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Input your Otp"),
                content: TextField(
                  controller: otp,
                ),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () async {
                      final response =
                          await _api.activateAccount(email, otp.text);
                      print(response.body);
                      if (response.statusCode == 200) {}
                    },
                  ),
                  TextButton(
                    child: Text("Resend OTP"),
                    onPressed: () async {
                      final response = await _api.resendOtp(email);
                      print(response.body);
                      if (response.statusCode == 200) {}
                    },
                  ),
                ],
              );
            },
            barrierDismissible: false,
          );
        }
      }
    } else if (response.statusCode == 400) {
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      _loggedInStatus = LoggedInStatus.LoggedOut;
      notifyListeners();
    }
  }

  Future<GetTokenResponse> loginForAndroidIos(context) async {
    String password;
    String email;
    GetTokenResponse tokenData;

    if (Platform.isAndroid) {
      email = "android@libmot.com";
      password = "Lme@onl1n3";
    } else {
      email = "ios@libmot.com";
      password = "Lme@onl1n3"; // TODO password not yet confirmed.
    }

    final response = await _api.login(email, password);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      tokenData = GetTokenResponse.fromJson(responseData);

      if (tokenData.code == "200") {
        final preference = await UserPreference.getInstance();
        preference.saveToken(tokenData);
      }
    }
    return tokenData;
  }

  Future<Profile> getProfile(String token) async {
    final response = await _api.profile(token);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final profile = Profile.fromJson(responseData);
      return profile;
    } else {
      _status = Status.Error;
      notifyListeners();
      return null;
    }
  }

  Future<void> getSavedProfile() async {
    final preference = await UserPreference.getInstance();
    profile = new Profile();
    profile.object = await preference.getProfile();
    notifyListeners();
    return profile;
  }

  signUpCustomer(context, signUp) async {
    Response response = await _api.signUpCustomer(signUp);
    print('body');
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('responseData');
      print(responseData);
      signedUpCustomers = SignUpCustomers.fromJson(responseData);
      print('signedUpCustomers');
      print(signedUpCustomers);
      if (signedUpCustomers.code == '200') {
        if (signedUpCustomers.object.isActive == false) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Input your Otp"),
                content: TextField(
                  controller: otp,
                ),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () async {
                      final response = await _api.activateAccount(
                          signedUpCustomers.object.phoneNumber, otp.text);
                      print(response.body);

                      if (response.statusCode == 200) {
                        final Map<String, dynamic> responseData =
                            json.decode(response.body);
                        GetTokenResponse data =
                            GetTokenResponse.fromJson(responseData);
                        if (data.code == '400')
                          Dialogs.showErrorSnackBar(
                              'Oops!', "${data.shortDescription}");
                        else{
                          Dialogs.showSuccessSnackBar(
                              'Oops!', "${data.shortDescription}");
                          Navigator.of(context).pushNamed("/dashboard");


                        }
                      } else {}
                    },
                  ),
                ],
              );
            },
          );

          //TODO send otp backend
        } else
          Dialogs.showErrorSnackBar('Oops!',
              "${signedUpCustomers.code} ${signedUpCustomers.shortDescription}");
      } else {
        print('error');
        print('${signedUpCustomers.shortDescription}');

        Dialogs.showErrorSnackBar('Oops!',
            "${signedUpCustomers.code} ${signedUpCustomers.shortDescription}");
      }
    } else
      Dialogs.showErrorSnackBar(
          'Oops!', "${signedUpCustomers.shortDescription}");
  }
}
