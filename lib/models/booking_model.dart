class BookingModel {
  int tripType;
  int paymentMethod;
  String posReference;
  int bookingType;
  int passengerType;
  String firstName;
  String lastName;
  int gender;
  int routeId;
  bool isSub;
  bool isSubReturn;
  int routeIdReturn;
  String luggageType;
  int subrouteId;
  int amount;
  int partCash;
  String posRef;
  int discount;
  String bookingReference;
  String ticketNumber;
  String approvedBy;
  String email;
  String phoneNumber;
  String address;
  String nextOfKinName;
  String nextOfKinPhone;
  String seatRegistrations;
  List<Beneficiaries> beneficiaries;
  int bookingStatus;
  int pickUpId;
  int pickupStatus;
  int returnPickUpId;
  int returnPickupStatus;
  bool isLoggedIn;
  int travelStatus;
  String payStackReference;
  String payStackResponse;
  PayStackPaymentResponse payStackPaymentResponse;
  String globalPayReference;
  String globalPayResponse;
  String quickTellerReference;
  String quickTellerResponse;
  bool hasCoupon;
  String couponCode;
  bool isGhanaRoute;
  String passportType;
  String passportId;
  String placeOfIssue;
  String issuedDate;
  String expiredDate;
  String nationality;
  String passportTypeId;
  String referralCode;

  BookingModel(
      {this.tripType,
      this.paymentMethod,
      this.posReference,
      this.bookingType,
      this.passengerType,
      this.firstName,
      this.lastName,
      this.gender,
      this.routeId,
      this.isSub,
      this.isSubReturn,
      this.routeIdReturn,
      this.luggageType,
      this.subrouteId,
      this.amount,
      this.partCash,
      this.posRef,
      this.discount,
      this.bookingReference,
      this.ticketNumber,
      this.approvedBy,
      this.email,
      this.phoneNumber,
      this.address,
      this.nextOfKinName,
      this.nextOfKinPhone,
      this.seatRegistrations,
      this.beneficiaries,
      this.bookingStatus,
      this.pickUpId,
      this.pickupStatus,
      this.returnPickUpId,
      this.returnPickupStatus,
      this.isLoggedIn,
      this.travelStatus,
      this.payStackReference,
      this.payStackResponse,
      this.payStackPaymentResponse,
      this.globalPayReference,
      this.globalPayResponse,
      this.quickTellerReference,
      this.quickTellerResponse,
      this.hasCoupon,
      this.couponCode,
      this.isGhanaRoute,
      this.passportType,
      this.passportId,
      this.placeOfIssue,
      this.issuedDate,
      this.expiredDate,
      this.nationality,
      this.passportTypeId,
      this.referralCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tripType'] = this.tripType;
    data['paymentMethod'] = this.paymentMethod;
    data['posReference'] = this.posReference;
    data['bookingType'] = this.bookingType;
    data['passengerType'] = this.passengerType;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['routeId'] = this.routeId;
    data['isSub'] = this.isSub;
    data['isSubReturn'] = this.isSubReturn;
    data['routeIdReturn'] = this.routeIdReturn;
    data['luggageType'] = this.luggageType;
    data['subrouteId'] = this.subrouteId;
    data['amount'] = this.amount;
    data['partCash'] = this.partCash;
    data['posRef'] = this.posRef;
    data['discount'] = this.discount;
    data['bookingReference'] = this.bookingReference;
    data['ticketNumber'] = this.ticketNumber;
    data['approvedBy'] = this.approvedBy;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['nextOfKinName'] = this.nextOfKinName;
    data['nextOfKinPhone'] = this.nextOfKinPhone;
    data['seatRegistrations'] = this.seatRegistrations;
    if (this.beneficiaries != null) {
      data['beneficiaries'] =
          this.beneficiaries.map((v) => v.toJson()).toList();
    }
    data['bookingStatus'] = this.bookingStatus;
    data['pickUpId'] = this.pickUpId;
    data['pickupStatus'] = this.pickupStatus;
    data['returnPickUpId'] = this.returnPickUpId;
    data['returnPickupStatus'] = this.returnPickupStatus;
    data['isLoggedIn'] = this.isLoggedIn;
    data['travelStatus'] = this.travelStatus;
    data['payStackReference'] = this.payStackReference;
    data['payStackResponse'] = this.payStackResponse;
    if (this.payStackPaymentResponse != null) {
      data['payStackPaymentResponse'] = this.payStackPaymentResponse.toJson();
    }
    data['globalPayReference'] = this.globalPayReference;
    data['globalPayResponse'] = this.globalPayResponse;
    data['quickTellerReference'] = this.quickTellerReference;
    data['quickTellerResponse'] = this.quickTellerResponse;
    data['hasCoupon'] = this.hasCoupon;
    data['couponCode'] = this.couponCode;
    data['isGhanaRoute'] = this.isGhanaRoute;
    data['passportType'] = this.passportType;
    data['passportId'] = this.passportId;
    data['placeOfIssue'] = this.placeOfIssue;
    data['issuedDate'] = this.issuedDate;
    data['expiredDate'] = this.expiredDate;
    data['nationality'] = this.nationality;
    data['passportTypeId'] = this.passportTypeId;
    data['referralCode'] = this.referralCode;
    return data;
  }
}

class Beneficiaries {
  String fullName;
  int seatNumber;
  int gender;
  int passengerType;

  Beneficiaries(
      {this.fullName, this.seatNumber, this.gender, this.passengerType});

  Beneficiaries.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    seatNumber = json['seatNumber'];
    gender = json['gender'];
    passengerType = json['passengerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['seatNumber'] = this.seatNumber;
    data['gender'] = this.gender;
    data['passengerType'] = this.passengerType;
    return data;
  }
}

class PayStackPaymentResponse {
  String reference;
  int approvedAmount;
  String authorizationCode;
  String cardType;
  String last4;
  bool reusable;
  String bank;
  String expireMonth;
  String expireYear;
  String transactionDate;
  String channel;
  String status;

  PayStackPaymentResponse(
      {this.reference,
      this.approvedAmount,
      this.authorizationCode,
      this.cardType,
      this.last4,
      this.reusable,
      this.bank,
      this.expireMonth,
      this.expireYear,
      this.transactionDate,
      this.channel,
      this.status});

  PayStackPaymentResponse.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    approvedAmount = json['approvedAmount'];
    authorizationCode = json['authorizationCode'];
    cardType = json['cardType'];
    last4 = json['last4'];
    reusable = json['reusable'];
    bank = json['bank'];
    expireMonth = json['expireMonth'];
    expireYear = json['expireYear'];
    transactionDate = json['transactionDate'];
    channel = json['channel'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference'] = this.reference;
    data['approvedAmount'] = this.approvedAmount;
    data['authorizationCode'] = this.authorizationCode;
    data['cardType'] = this.cardType;
    data['last4'] = this.last4;
    data['reusable'] = this.reusable;
    data['bank'] = this.bank;
    data['expireMonth'] = this.expireMonth;
    data['expireYear'] = this.expireYear;
    data['transactionDate'] = this.transactionDate;
    data['channel'] = this.channel;
    data['status'] = this.status;
    return data;
  }
}
