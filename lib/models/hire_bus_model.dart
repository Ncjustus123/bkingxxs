class HireBusModel {
  String firstName;
  String lastName;
  String middleName;
  String gender;
  String email;
  String phoneNumber;
  String address;
  String nextOfKinName;
  String nextOfKinPhoneNumber;
  int numberOfBuses;
  String requestDate;
  String departureDate;
  String departure;
  String destination;

  HireBusModel({
    this.firstName,
    this.lastName,
    this.middleName,
    this.gender,
    this.email,
    this.phoneNumber,
    this.address,
    this.nextOfKinName,
    this.nextOfKinPhoneNumber,
    this.numberOfBuses,
    this.requestDate,
    this.departureDate,
    this.departure,
    this.destination,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['nextOfKinName'] = this.nextOfKinName;
    data['nextOfKinPhoneNumber'] = this.nextOfKinPhoneNumber;
    data['numberOfBuses'] = this.numberOfBuses;
    data['departureDate'] = this.departureDate;
    data['requestDate'] = this.requestDate;
    data['departure'] = this.departure;
    data['departure'] = this.departure;
    data['destination'] = this.destination;

    return data;
  }
}
