class GetBusesResponseModel {
  String code;
  String shortDescription;
  Object object;

  GetBusesResponseModel({this.code, this.shortDescription, this.object});

  GetBusesResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
  }

}

class Object {
  int tripType;
  List<Buses> departures;
  List<Buses> arrivals;

  Object({this.tripType, this.departures, this.arrivals});

  Object.fromJson(Map<String, dynamic> json) {
    tripType = json['tripType'];
    if (json['departures'] != null) {
      departures =  [];
      json['departures'].forEach((v) {
        departures.add(new Buses.fromJson(v));
      });
    }else{
      departures = [];
    }
    if (json['arrivals'] != null) {
      arrivals = [];
      json['arrivals'].forEach((v) {
        arrivals.add(new Buses.fromJson(v));
      });
      
    }else{
      arrivals = [];
    }
  }


}

class Buses {
  String routeName;
  int routeId;
  String tripId;
  String vehicleName;
  String departureDate;
  String dateCreated;
  String departureTime;
  int availableNumberOfSeats;
  double farePrice;
  double memberFare;
  double childFare;
  double adultFare;
  double returnFare;
  double promoFare;
  double appFare;
  double appReturnFare;
  bool hasPickup;
  int bookedSeat;
  double vehicleModelId;
  String vehicleModel;
  bool isSub;
  bool isSubReturn;
  List<int> bookedSeats;
  List<int> mIncludedSeats;
  int totalNumberOfSeats;
  List<int> availableSeats;
  List<int> excludedSeats;
  String vehicleTripRegistrationId;
  int parentRouteId;
  int journeyStatus;
  int journeyType;

  Buses(
      {this.routeName,
      this.routeId,
      this.tripId,
      this.vehicleName,
      this.departureDate,
      this.dateCreated,
      this.departureTime,
      this.availableNumberOfSeats,
      this.farePrice,
      this.memberFare,
      this.childFare,
      this.adultFare,
      this.returnFare,
      this.promoFare,
      this.appFare,
      this.appReturnFare,
      this.hasPickup,
      this.bookedSeat,
      this.vehicleModelId,
      this.vehicleModel,
      this.isSub,
      this.isSubReturn,
      this.bookedSeats,
      this.mIncludedSeats,
      this.totalNumberOfSeats,
      this.availableSeats,
      this.excludedSeats,
      this.vehicleTripRegistrationId,
      this.parentRouteId,
      this.journeyStatus,
      this.journeyType});

  Buses.fromJson(Map<String, dynamic> json) {
    routeName = json['routeName'];
    routeId = json['routeId'];
    tripId = json['tripId'];
    vehicleName = json['vehicleName'];
    departureDate = json['departureDate'];
    dateCreated = json['dateCreated'];
    departureTime = json['departureTime'];
    availableNumberOfSeats = json['availableNumberOfSeats'];
    farePrice = json['farePrice'];
    memberFare = json['memberFare'];
    childFare = json['childFare'];
    adultFare = json['adultFare'];
    returnFare = json['returnFare'];
    promoFare = json['promoFare'];
    appFare = json['appFare'];
    appReturnFare = json['appReturnFare'];
    hasPickup = json['hasPickup'];
    bookedSeat = json['bookedSeat'];
    vehicleModelId = json['vehicleModelId'];
    vehicleModel = json['vehicleModel'];
    isSub = json['isSub'];
    isSubReturn = json['isSubReturn'];
    bookedSeats = json['bookedSeats'].cast<int>();
    mIncludedSeats = json['mIncludedSeats'].cast<int>();
    totalNumberOfSeats = json['totalNumberOfSeats'];
    availableSeats = json['availableSeats'].cast<int>();
    excludedSeats = json['excludedSeats'].cast<int>();
    vehicleTripRegistrationId = json['vehicleTripRegistrationId'];
    parentRouteId = json['parentRouteId'];
    journeyStatus = json['journeyStatus'];
    journeyType = json['journeyType'];
  }

}


