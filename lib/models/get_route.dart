class GetRouteModel {
  String code;
  String shortDescription;
  Object object;

  GetRouteModel({this.code, this.shortDescription, this.object});

  GetRouteModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
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

class Object {
  List<RouteItems> items;
  int count;
  int pageCount;
  int totalItemCount;
  int pageNumber;
  int pageSize;
  bool hasPreviousPage;
  bool hasNextPage;

  Object(
      {this.items,
      this.count,
      this.pageCount,
      this.totalItemCount,
      this.pageNumber,
      this.pageSize,
      this.hasPreviousPage,
      this.hasNextPage});

  Object.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new RouteItems.fromJson(v));
      });
    }
    count = json['count'];
    pageCount = json['pageCount'];
    totalItemCount = json['totalItemCount'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['pageCount'] = this.pageCount;
    data['totalItemCount'] = this.totalItemCount;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    return data;
  }
}

class RouteItems {
  int id;
  String name;
  String code;
  String contactPersonNo;
  double latitude;
  double longitude;
  bool isNew;
  String startDate;
  int terminalType;
  int bookingType;
  int stateId;
  String stateName;
  int routeId;
  bool isCommision;
  double onlineDiscount;
  bool isOnlineDiscount;
  String address;
  String contactPerson;
  String image;

  RouteItems(
      {this.id,
      this.name,
      this.code,
      this.contactPersonNo,
      this.latitude,
      this.longitude,
      this.isNew,
      this.startDate,
      this.terminalType,
      this.bookingType,
      this.stateId,
      this.stateName,
      this.routeId,
      this.isCommision,
      this.onlineDiscount,
      this.isOnlineDiscount,
      this.address,
      this.contactPerson,
      this.image});

  RouteItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    contactPersonNo = json['contactPersonNo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNew = json['isNew'];
    startDate = json['startDate'];
    terminalType = json['terminalType'];
    bookingType = json['bookingType'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    routeId = json['routeId'];
    isCommision = json['isCommision'];
    onlineDiscount = json['onlineDiscount'];
    isOnlineDiscount = json['isOnlineDiscount'];
    address = json['address'];
    contactPerson = json['contactPerson'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['contactPersonNo'] = this.contactPersonNo;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isNew'] = this.isNew;
    data['startDate'] = this.startDate;
    data['terminalType'] = this.terminalType;
    data['bookingType'] = this.bookingType;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['routeId'] = this.routeId;
    data['isCommision'] = this.isCommision;
    data['onlineDiscount'] = this.onlineDiscount;
    data['isOnlineDiscount'] = this.isOnlineDiscount;
    data['address'] = this.address;
    data['contactPerson'] = this.contactPerson;
    data['image'] = this.image;
    return data;
  }
}
