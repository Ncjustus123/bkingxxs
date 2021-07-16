import 'package:Libmot_Mobile/services/networking/getBase.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:flutterwave/models/responses/charge_response.dart';

class FlutterwavePayment {
  final currency = "";
  String amount;
  String txref;
  String phoneNumber;
  BuildContext context;
  String email;
  String fullName;

  FlutterwavePayment(
      {@required this.email,
      @required this.context,
      @required this.phoneNumber,
      @required this.txref,
      @required this.amount,
      @required this.fullName});
//PAY WITH FLUTTERWAVE
  beginFlutterwavePayment() async {
    final Flutterwave flutterwave = Flutterwave.forUIPayment(
        context: context,
        encryptionKey: baseInstance.base.flutterwaveEncryptionKey,
        publicKey: baseInstance.base.flutterwavePublicKey,
        currency: FlutterwaveCurrency.NGN,
        amount: amount,
        email: email,
        fullName: fullName,
        txRef: txref,
        isDebugMode: true,
        phoneNumber: phoneNumber,
        acceptCardPayment: true,
        acceptUSSDPayment: true,
        acceptAccountPayment: true,
        acceptFrancophoneMobileMoney: false,
        acceptGhanaPayment: false,
        acceptMpesaPayment: false,
        acceptRwandaMoneyPayment: true,
        acceptUgandaPayment: false,
        acceptZambiaPayment: false);

    try {
      final ChargeResponse response =
          await flutterwave.initializeForUiPayments();
      if (response == null) {
        // user didn't complete the transaction.
        print("transaction not complete");
      } else {
        final isSuccessful = checkPaymentIsSuccessful(response);
        if (isSuccessful) {
          print("Successful");
          // provide value to customer
        } else {
          // check message
          print(response.message);
          // check status
          print(response.status);

          // check processor error
          print(response.data.processorResponse);
        }
      }
    } catch (error, stacktrace) {
      // handleError(error);
      print(error);
      print(stacktrace);
    }
  }

  bool checkPaymentIsSuccessful(final ChargeResponse response) {
    return response.data.status == FlutterwaveConstants.SUCCESSFUL &&
        response.data.currency == this.currency &&
        response.data.amount == this.amount &&
        response.data.txRef == this.txref;
  }
}
