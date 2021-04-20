class SignUpCustomers {
  String code;
  String shortDescription;
  SignUpCustomersObject object;

  SignUpCustomers({this.code, this.shortDescription, this.object});

  SignUpCustomers.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new SignUpCustomersObject.fromJson(json['object']) : null;
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

class SignUpCustomersObject {
  int userId;
  bool isActive;
  int userType;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  bool accountIsDeleted;
  int gender;
  String referralCode;
  String password;

  SignUpCustomersObject(
      {this.userId,
      this.isActive,
      this.userType,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.accountIsDeleted,
      this.gender,
      this.referralCode,
      this.password});

  SignUpCustomersObject.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isActive = json['isActive'];
    userType = json['userType'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    accountIsDeleted = json['accountIsDeleted'];
    gender = json['gender'];
    referralCode = json['referralCode'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['isActive'] = this.isActive;
    data['userType'] = this.userType;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['accountIsDeleted'] = this.accountIsDeleted;
    data['gender'] = this.gender;
    data['referralCode'] = this.referralCode;
    data['password'] = this.password;
    return data;
  }
}
