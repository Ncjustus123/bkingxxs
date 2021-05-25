class PostBookingResponse {
  String code;
  String shortDescription;
  Object object;

  PostBookingResponse({this.code, this.shortDescription, this.object});

  PostBookingResponse.fromJson(Map<String, dynamic> json) {
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
  int seatNumber;
  String response;
  double amount;
  int mainBookerId;
  String bookingReferenceCode;

  Object(
      {this.seatNumber,
      this.response,
      this.amount,
      this.mainBookerId,
      this.bookingReferenceCode});

  Object.fromJson(Map<String, dynamic> json) {
    seatNumber = json['seatNumber'];
    response = json['response'];
    amount = json['amount'];
    mainBookerId = json['mainBookerId'];
    bookingReferenceCode = json['bookingReferenceCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seatNumber'] = this.seatNumber;
    data['response'] = this.response;
    data['amount'] = this.amount;
    data['mainBookerId'] = this.mainBookerId;
    data['bookingReferenceCode'] = this.bookingReferenceCode;
    return data;
  }
}
