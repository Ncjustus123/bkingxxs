class DepatureTerminalModel {
  String code;
  String shortDescription;
  List<DepatureObject> object;

  DepatureTerminalModel({this.code, this.shortDescription, this.object});

  DepatureTerminalModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    if (json['object'] != null) {
      object = new List<DepatureObject>();
      json['object'].forEach((v) {
        object.add(new DepatureObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['shortDescription'] = this.shortDescription;
    if (this.object != null) {
      data['object'] = this.object.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DepatureObject {
  int id;
  String name;
  double latitude;
  double longitude;
  bool isNew;
  int terminalType;
  int bookingType;
  int stateId;
  int routeId;
  bool isCommision;
  double onlineDiscount;
  bool isOnlineDiscount;

  DepatureObject(
      {this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.isNew,
      this.terminalType,
      this.bookingType,
      this.stateId,
      this.routeId,
      this.isCommision,
      this.onlineDiscount,
      this.isOnlineDiscount});

  DepatureObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNew = json['isNew'];
    terminalType = json['terminalType'];
    bookingType = json['bookingType'];
    stateId = json['stateId'];
    routeId = json['routeId'];
    isCommision = json['isCommision'];
    onlineDiscount = json['onlineDiscount'];
    isOnlineDiscount = json['isOnlineDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isNew'] = this.isNew;
    data['terminalType'] = this.terminalType;
    data['bookingType'] = this.bookingType;
    data['stateId'] = this.stateId;
    data['routeId'] = this.routeId;
    data['isCommision'] = this.isCommision;
    data['onlineDiscount'] = this.onlineDiscount;
    data['isOnlineDiscount'] = this.isOnlineDiscount;
    return data;
  }
}
