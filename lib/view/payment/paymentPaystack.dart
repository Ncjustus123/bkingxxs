import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/services/networking/test_data.dart';
import 'package:Libmot_Mobile/view/booking/booking_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';
import 'package:Libmot_Mobile/models/paymentPaystackModel.dart';

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
  PaymentModelObject object;
  @override
  void initState() {
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
                color: Get.isDarkMode ? Color(0xFF85000D) : Colors.indigo[900],
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
                      color: Get.isDarkMode
                          ? Color(0xFF85000D)
                          : Colors.indigo[500],
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1.2, color: Colors.white.withOpacity(0.2))),
                  child: Center(
                    child: Container(
                        height: 65,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Color(0xFF85000D)
                                : Colors.indigo[800],
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
            color: Get.isDarkMode ? Color(0xFF89000D) : Colors.indigo[900],
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
                          showLoading(
                              progressColor: Get.isDarkMode
                                  ? Color(0xFF85000D)
                                  : Colors.red,
                              indicatorColor: Get.isDarkMode
                                  ? Color(0xFF85000D)
                                  : Colors.red,
                              backgroundColor: Get.isDarkMode
                                  ? Color(0xFF020504)
                                  : Colors.white,
                              textColor: Get.isDarkMode
                                  ? Color(0xFF85000D)
                                  : Colors.red,
                              indicatorType: EasyLoadingIndicatorType.circle,
                              status: "\nLoading.....");
                          processPayment(context);
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
    print(card);
    if (card.isValid()) {
      print(card.isValid().toString());
      Charge c = Charge();
      c.amount = (booking.totalestimate * 100).toInt();
      //booking.postBookingResponse.object.amount.toInt();
      c.card = card;
      c.email = booking.booking.email;
      c.reference = booking.postBookingResponse.object.bookingReferenceCode;
      print(c.card);
      try {
        initializePayment(c, context);
      } catch (e) {}
    }
  }

  void initializePayment(Charge c, context) async {
    print(c.card.number);
    final response = await plugin.checkout(context, charge: c);
    print('response');
    //if message: Duplicate Transaction Reference, show a snackbarr
    print(response);
    if (response.status) {
      await processPaystackPayment();
    } else {
      Get.snackbar(
        "Error",
        "cant process request",
        icon: Icon(
          Icons.emoji_emotions,
          color: Colors.red,
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.black54,
        colorText: Colors.white,
      );
      EasyLoading.dismiss();
    }

    // Use the response
  }

  Future<void> processPaystackPayment() async {
    object = PaymentModelObject(
      email: booking.booking.email,
      amount: booking.postBookingResponse.object.amount.toInt(),
      refCode: booking.postBookingResponse.object.bookingReferenceCode,
      paystackrefrence: 5,
    );

    print("object");
    print(object);
    final response = await ApiCalls().payStackPayment(
        object.toJson());
    print('backend');
    print(response.body);
    if (response.statusCode == 200) {
      print("payment sucess");
      EasyLoading.dismiss();

      dialog(context, "Payment Successful",
          "Your booking 0f ${getNairaSign()}${booking.totalestimate} was successful",
          onpressed: () {
        Get.to(BookingConfirmation());
      });
    } else {
      print("payment failed");
      EasyLoading.dismiss();
    }
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
