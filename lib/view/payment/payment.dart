import 'dart:io';

import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/services/networking/test_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/view/payment/paymentPaystack.dart';


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: TestData().paystackPublicKey);
    super.initState();
  }

  Dialog successDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_box,
                color: Colors.green,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Payment has successfully',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'been made',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Your payment has been successfully",
                style: TextStyle(fontSize: 13),
              ),
              Text("processed.", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Dialog errorDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        height: 350.0,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 90,
              ),
              SizedBox(height: 15),
              Text(
                'Failed to process payment',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                "Error in processing payment, please try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return successDialog(context);
      },
    );
  }

  void _showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return errorDialog(context);
      },
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  // chargeCard() async {
  //   Charge charge = Charge()
  //     ..amount = (booking.postBookingResponse.object.amount * 100).toInt()
  //     //..amount = 10000*100
  //     ..reference = _getReference()
  //     // or ..accessCode = _getAccessCodeFrmInitialization()
  //     ..email = booking.booking.email;
  //   CheckoutResponse response = await plugin
  //       .checkout(
  //     context,
  //     method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
  //     charge: charge,
  //     fullscreen: true,
  //     logo: Image.asset(
  //       "images/LIBMOT LOGO 1.png",
  //       height: 35,
  //     ),
  //   )
  //       .then((response) async {
  //     if (response.status == true) {
  //       await processPaystackPayment();
  //       print(" this${response.message}");
  //       _showDialog();
  //     } else {
  //       _showErrorDialog();
  //     }
  //   });
  // }

  // Future<void> processPaystackPayment() async {
  //   Map object = {
  //     "email": booking.booking.email,
  //     "amount": booking.postBookingResponse.object.amount,
  //     "referenceNumber":
  //         booking.postBookingResponse.object.bookingReferenceCode,
  //     "PayStackReference": 5,
  //   };
  //   Response response = await ApiCalls().payStackPayment(object);
  // }

  BookingRepository booking;

  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    booking = Provider.of<BookingRepository>(context);
    //int amounts = booking.postBookingResponse.object.amount.toInt();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(
              context,
              "Select Payment Method",
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 500),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            booking.beginFlutterwavePayment(
                                context,
                                booking.postBookingResponse.object.amount
                                    .toString(),
                                booking.booking.email,
                                booking.booking.firstName,
                                booking.postBookingResponse.object
                                    .bookingReferenceCode,
                                booking.booking.phoneNumber);
                          },
                          child: Image.asset(
                            "images/flutterwave.png",
                            height: 60,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.to(PaymentPaystack()),

                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) =>
                          //             PaymentPaystack()));

                          child: Image.asset(
                            "images/paystack.png",
                            height: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
