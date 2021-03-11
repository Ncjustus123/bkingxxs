import 'dart:convert';

import 'package:Libmot_Mobile/models/get_token_model.dart';
import 'package:Libmot_Mobile/models/profile_model.dart';
import 'package:Libmot_Mobile/resources/database/user_preference.dart';
import 'package:Libmot_Mobile/view/welcome_page.dart';

import '../resources/networking/api_calls.dart';
import 'package:flutter/material.dart';

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

  Status get status => _status;

  LoggedInStatus get loggedInStatus => _loggedInStatus;

  checkLogin() async {
    final preference = await UserPreference.getInstance();
    bool loggedIn = preference.isLoggedIn() ?? false;
    (loggedIn)
        ? _loggedInStatus = LoggedInStatus.LoggedIn
        : _loggedInStatus = LoggedInStatus.LoggedOut;
    notifyListeners();
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
    final response = await ApiCalls().profile(token);
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

  Future<Profile> getSavedProfile() async {
    final preference = await UserPreference.getInstance();
    profile = await preference.getProfile();
    return profile;
  }
}
