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

  static final String token = "token";
  static final String refreshToken = "refreshToken";
  static final String expiresIn = "expiresIn";

  static final String loggedIn = "loggedIn";
  static final String firstName = "firstName";
  static final String lastName = "lastName";
  static final String email = "email";
  static final String phoneNumber = "phoneNumber";
  static final String gender = "gender";
  static final String nextOfKin = "nextOfKin";
  static final String nextOfKinPhone = "nextOfKinPhone";

  static final String referralCode = "referralCode";
  static final String userType = "userType";
  static final String companyId = "companyId";
  static final String dateJoined = "dateJoined";

  void setLoggedInState(bool isLoggedIn) {
    preferences.setBool(loggedIn, isLoggedIn);
  }

  bool isLoggedIn() {
    return preferences.getBool(loggedIn);
  }

  void saveToken(GetTokenResponse tokenResponse) async {
    preferences.setString(token, tokenResponse.object.token);
    preferences.setString(refreshToken, tokenResponse.object.refreshToken);
    preferences.setString(expiresIn, tokenResponse.object.expires);
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

  Future<ProfileObject> getProfile() async {
    final profile = ProfileObject();
   
    profile.firstName = preferences.getString(firstName);
    profile.lastName = preferences.getString(lastName);
    profile.email = preferences.getString(email);
    profile.phoneNumber = preferences.getString(phoneNumber);
    profile.gender = preferences.getString(gender);
    profile.nextOfKin = preferences.getString(nextOfKin);
    profile.nextOfKinPhone = preferences.getString(nextOfKinPhone);
    profile.referralCode = preferences.getString(referralCode);
    profile.userType = preferences.getInt(userType);
    profile.companyId = preferences.getInt(companyId);

    return profile;
  }

  Future<String> getToken() async {
    String token = preferences.getString("token");
    return token;
  }

  void deleteProfile() {
    preferences.clear();
  }
}
