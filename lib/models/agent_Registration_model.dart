class AgentRegistration {
  String firstName;
  String middleName;
  String lastName;
  String address;
  String email;
  int gender;
  String phone;
  String nextOfKin;
  String nextOfKinPhone;
  String companyName;
  String natureOfBusiness;
  String companyAddress;
  String businessPhone;
  String companyEmail;
  int agentType;

  AgentRegistration(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.address,
      this.email,
      this.gender,
      this.phone,
      this.nextOfKin,
      this.nextOfKinPhone,
      this.companyName,
      this.natureOfBusiness,
      this.companyAddress,
      this.businessPhone,
      this.companyEmail,
      this.agentType});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['Address'] = this.address;
    data['Email'] = this.email;
    data['Gender'] = this.gender;
    data['Phone'] = this.phone;
    data['NextOfKin'] = this.nextOfKin;
    data['NextOfKinPhone'] = this.nextOfKinPhone;
    data['CompanyName'] = this.companyName;
    data['NatureOfBusiness'] = this.natureOfBusiness;
    data['CompanyAddress'] = this.companyAddress;
    data['BusinessPhone'] = this.businessPhone;
    data['CompanyEmail'] = this.companyEmail;
    data['AgentType'] = this.agentType;
    return data;
  }
}
