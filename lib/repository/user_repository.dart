import 'dart:convert';
import 'dart:io';

import 'package:Libmot_Mobile/models/get_token_model.dart';
import 'package:Libmot_Mobile/models/profile_model.dart';
import 'package:Libmot_Mobile/models/sign_up_model.dart';
import 'package:Libmot_Mobile/resources/database/user_preference.dart';
import 'package:http/http.dart';

import '../resources/networking/api_calls.dart';
import 'package:flutter/material.dart';

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
    bool loggedIn = preference.isLoggedIn() ?? false;
    if (loggedIn) {
      _loggedInStatus = LoggedInStatus.LoggedIn;
      Navigator.of(context).pushNamed(dashboardRoute);
    } else {
      _loggedInStatus = LoggedInStatus.LoggedOut;
      Navigator.of(context).pushNamed(welcomeRoute);
    }
  }

  logout() async {
    final pref = await UserPreference.getInstance();
    pref.deleteProfile();
    _loggedInStatus = LoggedInStatus.LoggedOut;
    notifyListeners();
  }

  loginRepo(String email, String password) async {
    // _status = Status.Authenticating;
    // notifyListeners();

    final response = await _api.login(email, password);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      GetTokenResponse tokenData = GetTokenResponse.fromJson(responseData);

      if (tokenData.code == "200") {
        final preference = await UserPreference.getInstance();
        //preference.saveToken(tokenData);
        profile = await getProfile(tokenData.object.token);
        preference.setLoggedInState(true);
        preference.saveProfile(profile);
        loginForAndroidIos();
        _loggedInStatus = LoggedInStatus.LoggedIn;
        notifyListeners();
      }
    } else {
      _loggedInStatus = LoggedInStatus.LoggedOut;
      notifyListeners();
    }
  }

  Future<GetTokenResponse> loginForAndroidIos() async {
    String password;
    String email;
    GetTokenResponse tokenData;

    if (Platform.isAndroid) {
      email = "android@libmot.com";
      password = "Lme@onl1n3";
    } else {
      email = "ios@libmot.com";
      password = "Lme@onl1n3";   // TODO password not yet confirmed.
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
    //return profile;
  }

  signUpCustomer(context) async {
    Response response = await _api.signUpCustomer(signUp.toJson());
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      signedUpCustomers = SignUpCustomers.fromJson(responseData);
      print(signedUpCustomers.object.email);
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
                FlatButton(
                  child: Text("OK"),
                  onPressed: () async {
                    final response = await _api.activateAccount(
                        signedUpCustomers.object.phoneNumber, otp.text);
                    print(response.body);
                    if (response.statusCode == 200) {}
                  },
                ),
              ],
            );
          },
        );

        //TODO send otp backend
      }
    }
  }
}
