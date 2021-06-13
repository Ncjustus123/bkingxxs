
import 'dart:io';
import 'package:Libmot_Mobile/payment.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/resources/networking/getBase.dart';
import 'package:Libmot_Mobile/resources/networking/test_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:provider/provider.dart';


class PaymentPaystack extends StatefulWidget {
  @override
  _PaymentPaystackState createState() => _PaymentPaystackState();
}

class _PaymentPaystackState extends State<PaymentPaystack> {
  final plugin = PaystackPlugin();
  @override
    void initState() {
       plugin.initialize(publicKey: baseInstance.base.paystackPublicKey);
    // PaystackPlugin.initialize(
    //     publicKey: "pk_test");
     super.initState();
  }
  BookingRepository booking;
  
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PAYSTACK",
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: FlatButton(
              color: Colors.green,
              child: Text("Charge", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
              onPressed: () {}
            ),
          )),
    );
  }
}
