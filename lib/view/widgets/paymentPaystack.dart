// import 'dart:io';
// import 'package:Libmot_Mobile/payment.dart';
// import 'package:Libmot_Mobile/repository/booking_repository.dart';
// import 'package:Libmot_Mobile/resources/networking/getBase.dart';
// import 'package:Libmot_Mobile/resources/networking/test_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:provider/provider.dart';

// class PaymentPaystack extends StatefulWidget {
//   @override
//   _PaymentPaystackState createState() => _PaymentPaystackState();
// }

// class _PaymentPaystackState extends State<PaymentPaystack> {
//   final plugin = PaystackPlugin();
//   @override
//     void initState() {
//        plugin.initialize(publicKey: baseInstance.base.paystackPublicKey);
//     // PaystackPlugin.initialize(
//     //     publicKey: "pk_test");
//      super.initState();
//   }
//   BookingRepository booking;

//   Widget build(BuildContext context) {
//     booking = Provider.of<BookingRepository>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "PAYSTACK",
//         ),
//         centerTitle: true,
//         elevation: 0.0,
//       ),
//       body: Container(
//           // padding: EdgeInsets.all(10),
//           child: Center(
//             child: FlatButton(
//               color: Colors.green,
//               child: Text("Charge", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
//               onPressed: () {}
//             ),
//           )),
//     );
//   }
// }


import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/resources/networking/getBase.dart';
import 'package:Libmot_Mobile/resources/networking/test_data.dart';
import 'package:Libmot_Mobile/view/initial_page.dart';
import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:provider/provider.dart';

class PaymentPaystack extends StatefulWidget {
  @override
  _PaymentPaystackState createState() => _PaymentPaystackState();
}

class _PaymentPaystackState extends State<PaymentPaystack> {
  final cardNumbercontroller = TextEditingController();
  final monthAndyearofCardExpiry = TextEditingController();
  final cardHoldername = TextEditingController();
  final cvv = TextEditingController();
  String cardNumber = "xxxx xxxx xxxx xxxx";
  String monthAndyear = "MM/YY";
  String cvvNumber = "CVV";
  String cardHolderName = "CARD HOLDER";
  final plugin = PaystackPlugin();
  BookingRepository booking;
  @override
  void initState(){
    plugin.initialize(publicKey: TestData().paystackPublicKey);
    super.initState();
  }

  _renderContent(context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0),
      // color: Color(0xFFB800BF),
      child: FlipCard(
        direction: FlipDirection.VERTICAL,
        speed: 1000,
        onFlipDone: (status) {
          print(status);
        },
        front: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo[900],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cardNumber,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(monthAndyear,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(cardHolderName,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.indigo[500],
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1.2, color: Colors.white.withOpacity(0.2))),
                  child: Center(
                    child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.2,
                                color: Colors.white.withOpacity(0.1)))),
                  )),
            )
          ],
        ),
        back: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.indigo[900],
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputFormField(
                label: cvvNumber,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              myWhiteAppBar(context, "Payment"),
              _renderContent(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputFormField(
                        label: 'Card Number',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(24),
                          MaskedTextInputFormatter(
                              mask: "XXXX XXXX XXXX XXXX XXXX", separator: " ")
                        ],
                        controller: cardNumbercontroller,
                        onChanged: (value) {
                          setState(() {
                            cardNumber = cardNumbercontroller.text;
                            value = cardNumbercontroller;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputFormField(
                              maxlenght: 5,
                              label: 'Expired Date',
                              keyboardType: TextInputType.number,
                              controller: monthAndyearofCardExpiry,
                              inputFormatters: [
                                CVVMaskedTextInputFormatter(
                                    mask: "XX XX", separator: "/")
                              ],
                              onChanged: (value) {
                                setState(() {
                                  monthAndyear = monthAndyearofCardExpiry.text;
                                  value = monthAndyearofCardExpiry;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: InputFormField(
                              maxlenght: 3,
                              label: 'CVV',
                              keyboardType: TextInputType.number,
                              controller: cvv,
                              onChanged: (value) {
                                setState(() {
                                  cvvNumber = cvv.text;
                                  value = cvv;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      InputFormField(
                        label: 'Card Holder',
                        textCapitalization: TextCapitalization.words,
                        controller: cardHoldername,
                        onChanged: (value) {
                          setState(() {
                            cardHolderName = cardHoldername.text;
                            value = cardHoldername;
                          });
                        },
                      ),
                      SmallButtonReusable(
                        name: "Proceed",
                        onpressed: () {
                          processPayment(context);
                          dialog(context, "Payment Successful",
                              "Your Payment of 10,000 was successful", () {
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 8;
                            });
                            setState(() {});
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void processPayment(context) {
    int month = int.parse(monthAndyearofCardExpiry.text.split("/")[0]);
    int year = int.parse(monthAndyearofCardExpiry.text.split("/")[1]);
    PaymentCard card = PaymentCard(
      number: cardNumbercontroller.text,
      cvc: cvv.text,
      expiryMonth: month,
      expiryYear: year,
    );
    if (!card.isValid()) {
      return;
    }
    Charge c = Charge();
    c.amount = booking.postBookingResponse.object.amount.toInt();
    c.card = card;
    c.email = booking.booking.email;
    c.reference = booking.postBookingResponse.object.bookingReferenceCode;
    try {
      initializePayment(c,context);
    } catch (e) {}
  }
  void initializePayment(Charge c,context) async{
   final response = await plugin.chargeCard(context, charge: c);
    // Use the response
  }
}




class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  RegExp regExp;
  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var reg = RegExp(r"^[0-9]+$");

    if (!reg.hasMatch(newValue.text.replaceAll(" ", ""))) {
      return oldValue;
    }

    if (newValue.text.endsWith(" ") &&
        newValue.text.length > oldValue.text.length) {
      return oldValue;
    }

    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.endsWith(' ')) {
          print("trimming");
          return TextEditingValue(
            text: newValue.text.substring(0, newValue.text.length - 2),
            selection: TextSelection.collapsed(
              offset: newValue.selection.end - 1,
            ),
          );
        }
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

class CVVMaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;
  CVVMaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var reg = RegExp(r"^[0-9]+$");
    if (newValue.text.length > 0) {
      if (newValue.text.length < oldValue.text.length) {
        return newValue;
      }
      if (!reg.hasMatch(newValue.text.replaceAll("/", ""))) {
        return oldValue;
      }
      if (newValue.text.length > 2) {
        String text = newValue.text.replaceAll("/", "");
        String n = '${text.substring(0, 2)}/${text.substring(2)}';
        return TextEditingValue(
            text: n,
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ));
      }
    }
    return newValue;
  }
}
