class CheckBookingDetailsResponse {
  String code;
  String shortDescription;
  Object object;

  CheckBookingDetailsResponse({this.code, this.shortDescription, this.object});

  CheckBookingDetailsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
  }
}

class Object {
  String refCode;
  int id;
  int seatNumber;
  int remainingSeat;
  String bookingReferenceCode;
  String mainBookerReferenceCode;
  String phoneNumber;
  String createdBy;
  String nextOfKinName;
  String nextOfKinPhoneNumber;
  String fullName;
  String dateCreated;
  String newDate;
  double amount;
  double discount;
  bool isMainBooker;
  bool isPrinted;
  bool isCrossSell;
  bool isSub;
  bool isSubReturn;
  bool hasReturn;
  bool isReturn;
  bool isRescheduled;
  bool isRerouted;
  bool isUpgradeDowngrade;
  int noOfTicket;
  bool fromTransload;
  int routeId;
  String routeName;
  bool rated;
  int bookingStatus;
  int pickupStatus;
  int travelStatus;
  int upgradeType;
  int passengerType;
  int paymentMethod;
  int bookingType;
  int rescheduleStatus;
  int rescheduleMode;
  int rerouteStatus;
  int rerouteMode;
  int gender;
  bool isExpired;
  bool hasCoupon;
  int departureTerminald;
  int destinationTerminalId;
  int rescheduleType;
  bool isGhanaRoute;

  Object(
      {this.refCode,
      this.id,
      this.seatNumber,
      this.remainingSeat,
      this.bookingReferenceCode,
      this.mainBookerReferenceCode,
      this.phoneNumber,
      this.createdBy,
      this.nextOfKinName,
      this.nextOfKinPhoneNumber,
      this.fullName,
      this.dateCreated,
      this.newDate,
      this.amount,
      this.discount,
      this.isMainBooker,
      this.isPrinted,
      this.isCrossSell,
      this.isSub,
      this.isSubReturn,
      this.hasReturn,
      this.isReturn,
      this.isRescheduled,
      this.isRerouted,
      this.isUpgradeDowngrade,
      this.noOfTicket,
      this.fromTransload,
      this.routeId,
      this.routeName,
      this.rated,
      this.bookingStatus,
      this.pickupStatus,
      this.travelStatus,
      this.upgradeType,
      this.passengerType,
      this.paymentMethod,
      this.bookingType,
      this.rescheduleStatus,
      this.rescheduleMode,
      this.rerouteStatus,
      this.rerouteMode,
      this.gender,
      this.isExpired,
      this.hasCoupon,
      this.departureTerminald,
      this.destinationTerminalId,
      this.rescheduleType,
      this.isGhanaRoute});

  Object.fromJson(Map<String, dynamic> json) {
    refCode = json['refCode'];
    id = json['id'];
    seatNumber = json['seatNumber'];
    remainingSeat = json['remainingSeat'];
    bookingReferenceCode = json['bookingReferenceCode'];
    mainBookerReferenceCode = json['mainBookerReferenceCode'];
    phoneNumber = json['phoneNumber'];
    createdBy = json['createdBy'];
    nextOfKinName = json['nextOfKinName'];
    nextOfKinPhoneNumber = json['nextOfKinPhoneNumber'];
    fullName = json['fullName'];
    dateCreated = json['dateCreated'];
    newDate = json['newDate'];
    amount = json['amount'];
    discount = json['discount'];
    isMainBooker = json['isMainBooker'];
    isPrinted = json['isPrinted'];
    isCrossSell = json['isCrossSell'];
    isSub = json['isSub'];
    isSubReturn = json['isSubReturn'];
    hasReturn = json['hasReturn'];
    isReturn = json['isReturn'];
    isRescheduled = json['isRescheduled'];
    isRerouted = json['isRerouted'];
    isUpgradeDowngrade = json['isUpgradeDowngrade'];
    noOfTicket = json['noOfTicket'];
    fromTransload = json['fromTransload'];
    routeId = json['routeId'];
    routeName = json['routeName'];
    rated = json['rated'];
    bookingStatus = json['bookingStatus'];
    pickupStatus = json['pickupStatus'];
    travelStatus = json['travelStatus'];
    upgradeType = json['upgradeType'];
    passengerType = json['passengerType'];
    paymentMethod = json['paymentMethod'];
    bookingType = json['bookingType'];
    rescheduleStatus = json['rescheduleStatus'];
    rescheduleMode = json['rescheduleMode'];
    rerouteStatus = json['rerouteStatus'];
    rerouteMode = json['rerouteMode'];
    gender = json['gender'];
    isExpired = json['isExpired'];
    hasCoupon = json['hasCoupon'];
    departureTerminald = json['departureTerminald'];
    destinationTerminalId = json['destinationTerminalId'];
    rescheduleType = json['rescheduleType'];
    isGhanaRoute = json['isGhanaRoute'];
  }
}
