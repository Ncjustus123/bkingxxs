import 'package:Libmot_Mobile/models/get_token_model.dart';
import 'package:Libmot_Mobile/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static UserPreference instance;
  SharedPreferences preferences;
  UserPreference({this.preferences});

  static Future<UserPreference> getInstance() async {
    if (instance != null) {
      return instance;
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return UserPreference(preferences: preferences);
    }
  }

  static const String loggedIn = "loggedIn";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String phoneNumber = "phoneNumber";
  static const String gender = "gender";
  static const String nextOfKin = "nextOfKin";
  static const String nextOfKinPhone = "nextOfKinPhone";

  static const String referralCode = "referralCode";
  static const String userType = "userType";
  static const String companyId = "companyId";
  static const String dateJoined = "dateJoined";

  void setLoggedInState(bool isLoggedIn) {
    preferences.setBool(loggedIn, isLoggedIn);
  }

  bool isLoggedIn() {
    return preferences.getBool(loggedIn);
  }

  void saveToken(GetTokenResponse token) async {
    preferences.setString("token", token.object.token);
    preferences.setString("refreshToken", token.object.refreshToken);
    preferences.setString("expiresIn", token.object.expires);
  }

  void saveProfile(Profile profile) {
    preferences.setString(firstName, profile.object.firstName);
    preferences.setString(lastName, profile.object.lastName);
    preferences.setString(email, profile.object.email);
    preferences.setString(phoneNumber, profile.object.phoneNumber);
    preferences.setString(gender, profile.object.gender);
    preferences.setString(nextOfKin, profile.object.nextOfKin);
    preferences.setString(nextOfKinPhone, profile.object.nextOfKinPhone);
    preferences.setString(referralCode, profile.object.referralCode);
    preferences.setString(dateJoined, profile.object.dateJoined);
    preferences.setInt(userType, profile.object.userType);
    preferences.setInt(companyId, profile.object.companyId);
  }

  Future<String> getToken() async {
    String token = preferences.getString("token");
    return token;
  }

  void deleteProfile() {
    preferences.clear();
  }
}
