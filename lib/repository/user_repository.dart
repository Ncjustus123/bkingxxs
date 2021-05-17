import 'dart:convert';

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
  SignUpCustomersObject signUp;
  SignUpCustomers signedUpCustomers;

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
        preference.saveToken(tokenData);
        profile = await getProfile(tokenData.object.token);
        preference.setLoggedInState(true);
        preference.saveProfile(profile);
        _loggedInStatus = LoggedInStatus.LoggedIn;
        notifyListeners();
      }
    } else {
      _loggedInStatus = LoggedInStatus.LoggedOut;
      notifyListeners();
    }
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

  signUpCustomer() async {
    signUp = SignUpCustomersObject(
      firstName: signUp.firstName,
      lastName: signUp.lastName,
      email: signUp.email,
      password: signUp.email,
      phoneNumber: signUp.phoneNumber,
      referralCode: signUp.referralCode,
      gender: signUp.gender,
    );
    Response response = await _api.signUpCustomer(signUp.toJson());
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      signedUpCustomers = SignUpCustomers.fromJson(responseData);
      if (signedUpCustomers.object.isActive == false) {
        //TODO send otp backend
      }
    }
  }
}
