class PaymentModel {
  String code;
  String shortDescription;
  PaymentModelObject object;

  PaymentModel({this.code, this.shortDescription, this.object});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shortDescription = json['shortDescription'];
    object =
        json['object'] != null ? new PaymentModelObject.fromJson(json['object']) : null;
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

class PaymentModelObject {
  int seatNumber;
  String response;
  String email;
  String refCode;
  int amount;
  int paystackrefrence;

  PaymentModelObject({this.seatNumber, this.response,this.email,this.amount,this.paystackrefrence,this.refCode});

  PaymentModelObject.fromJson(Map<String, dynamic> json) {
    seatNumber = json['seatNumber'];
    response = json['response'];
    email = json['email'];
    refCode = json['refCode'];
    amount = json['amount'];
    paystackrefrence = json['paystackrefrence'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seatNumber'] = this.seatNumber;
    data['response'] = this.response;
    data['email'] = this.email;
    data['refCode'] = this.refCode;
    data['amount'] = this.amount;
    data['paystackrefrence'] = this.paystackrefrence;
    return data;
  }
}
