import 'api_response.dart';

class CreditCard implements BluePrint {
  String cardNumber;
  String cvv;
  int expMonth;
  int expYear;

  CreditCard({this.cardNumber, this.cvv, this.expMonth, this.expYear});

  factory CreditCard.fromJson(json) {
    return CreditCard(
        cardNumber: json['cardNumber'],
        cvv: json['cvv'],
        expMonth: json['expMonth'],
        expYear: json['expYear']);
  }

  @override
  CreditCard fromJSON(json) {
    return CreditCard.fromJson(json);
  }

  @override
  Map toJSON() {
    var map = {};
    map['cardNumber'] = cardNumber;
    map['cvv'] = cvv;
    map['expMonth'] = expMonth;
    map['expYear'] = expYear;
    return map;
  }
}
class TransactionObject implements BluePrint {
  String Id;
  String TransactionType;
  String TransType;
  double TransactionAmount;
  String TransactionDate;
  double LineBalance;
  int WalletId;
  String TransactionDescription;
  String Reference;
  bool IsCompleted;
  String WayBill;
  String PayStackReference;
  String paymentMethod;

  TransactionObject(
      {this.Id,
        this.TransactionType,
        this.TransType,
        this.TransactionAmount,
        this.TransactionDate,
        this.LineBalance,
        this.WalletId,
        this.TransactionDescription,
        this.Reference,
        this.IsCompleted,
        this.WayBill,
        this.PayStackReference,
        this.paymentMethod});

  factory TransactionObject.fromJson(json) {
    return TransactionObject(
        Id: json['Id'],
        IsCompleted: json['IsCompleted'],
        LineBalance: json['LineBalance'],
        paymentMethod: json['paymentMethod'],
        PayStackReference: json['payStackreference'],
        Reference: json['Reference'],
        TransactionAmount: json['TransactionAmount'],
        TransactionDate: json['TransactionDate'],
        TransactionDescription: json['TransactionDescription'],
        TransactionType: json['TransType'],
        TransType: json['TransType'],
        WalletId: json['WalletId'],
        WayBill: json['WayBill']);
  }

  @override
  fromJSON(json) {
    return TransactionObject.fromJson(json);
  }

  @override
  Map toJSON() {
    // TODO: implement toJSON
    return null;
  }
}

