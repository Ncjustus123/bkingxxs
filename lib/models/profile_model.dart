class Profile {
  String code;
  String shortDescription;
  ProfileObject object;

  Profile({this.code, this.shortDescription, this.object});

  Profile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new ProfileObject.fromJson(json['object']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    if (this.object != null) {
      data['object'] = this.object.toJson();
    }
    return data;
  }
}

class ProfileObject {
  String nextOfKin;
  String nextOfKinPhone;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String gender;
  String referralCode;
  String dateJoined;
  int userType;
  int companyId;

  ProfileObject(
      {this.nextOfKin,
      this.nextOfKinPhone,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.gender,
      this.referralCode,
      this.dateJoined,
      this.userType,
      this.companyId});

  ProfileObject.fromJson(Map<String, dynamic> json) {
    nextOfKin = json['nextOfKin'];
    nextOfKinPhone = json['nextOfKinPhone'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    referralCode = json['referralCode'];
    dateJoined = json['dateJoined'];
    userType = json['userType'];
    companyId = json['companyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextOfKin'] = this.nextOfKin;
    data['nextOfKinPhone'] = this.nextOfKinPhone;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['gender'] = this.gender;
    data['referralCode'] = this.referralCode;
    data['dateJoined'] = this.dateJoined;
    data['userType'] = this.userType;
    data['companyId'] = this.companyId;
    return data;
  }
}