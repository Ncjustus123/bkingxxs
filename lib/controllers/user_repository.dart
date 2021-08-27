import 'dart:convert';
import 'dart:io';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/models/get_token_model.dart';
import 'package:Libmot_Mobile/models/profile_model.dart';
import 'package:Libmot_Mobile/models/sign_up_model.dart';
import 'package:Libmot_Mobile/services/database/user_preference.dart';
import 'package:Libmot_Mobile/view/login/login_page.dart';
import 'package:Libmot_Mobile/view/login/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as route;
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/networking/api_calls.dart';
import 'package:Libmot_Mobile/view/dasboard_view/dashboard_page.dart';
import 'package:Libmot_Mobile/view/onboarding/onboarding_page.dart';
import 'package:Libmot_Mobile/view/welcome/welcome_page.dart';

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
  Image image;

  Status get status => _status;
  var time;

  LoggedInStatus get loggedInStatus => _loggedInStatus;

  buildDialog(context) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: image,
      ),
    );
  }

  checkLogin(BuildContext context) async {
    // final preference = await UserPreference.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // bool loggedIn = preference.isLoggedIn() ?? false;
    final newUser = prefs.getString('isNewUser');
    print('newUser');
    print(newUser);

    if (newUser == 'No') {
      print('I am here');
      // if (loggedIn) {
      _loggedInStatus = LoggedInStatus.LoggedIn;
      // route.Get.offAll(() => DashboardPage());

      // } else {
      //   _loggedInStatus = LoggedInStatus.LoggedOut;
      //   await prefs.clear();
      route.Get.offAll(() => LoginPage());

      //
      // }
    } else {
      // await prefs.clear();
      route.Get.offAll(() => OnBoardingPage());
    }
  }

  logout(context) async {
    // final pref = await UserPreference.getInstance();
    // pref.deleteProfile();
    _loggedInStatus = LoggedInStatus.LoggedOut;
    Provider.of<UserRepository>(context, listen: false).profile = null;

    Get.offAll(() => LoginPage());
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
        preference.saveLogin(email,password);
        profile = await getProfile(tokenData.object.token);
        preference.setLoggedInState(true);
        preference.saveProfile(profile);
        loginForAndroidIos(context);
        _loggedInStatus = LoggedInStatus.LoggedIn;

        Get.offAll(() => LoginAnim());

        notifyListeners();
      } else {
        print('error');
        print('error');
        print('${tokenData.shortDescription}');
        if ("${tokenData.shortDescription}" ==
            "Account not active. Please activate your acccount to continue.") {
          Get.back();

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
        } else {
          Get.back();

          Dialogs.showErrorSnackBar('Oops!', "${tokenData.shortDescription}");
        }
      }
    } else if (response.statusCode == 400) {
      Get.back();
      Dialogs.showErrorSnackBar('Oops!', "Failed to login Try again");
      EasyLoading.dismiss();
    } else {
      Get.back();
      Dialogs.showErrorSnackBar('Sorry!', "Try again later");

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
    print(response.body);
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

   updateProfile(context)async{
    showFetchingData('Processing ..');
    final response = await _api.updateProfile(profile.toJson());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("responseData");
      print(responseData);
      profile = Profile.fromJson(responseData);

      //TODO: end the first dialog box

      //show dialog box
      EasyLoading.dismiss();
      Dialogs.showMessage(
        context: context,
        message:
        'Profile Updated Successfully',
      );
    }
    else{
      Get.snackbar("oops", "Could not update profile");
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
    var response = await _api.signUpCustomer(signUp);
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
                        else {
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
