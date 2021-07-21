import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/Buttons/buttons.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApplyCoupon extends StatefulWidget {
  @override
  _ApplyCouponState createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  bool checkValue = false;
  BookingRepository repository;

  @override
  Widget build(BuildContext context) {
    repository = Provider.of<BookingRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: _width,
        height: _height,
        child: Column(children: [
          myAppBar(context, 'Apply Coupon'),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Do you have a coupon?",
                    ),
                    InputFormField(
                      label: 'Coupon code(optional)',
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    WhiteButtonReusable(
                      onpressed: () async {
                        repository.couponProceedButton(context);
                      },
                      name: "Apply coupon",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("FarePrice:",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600)),
                          ),
                          Expanded(
                            child: Text("${getNairaSign()}${repository.totalestimate}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Monserrat",
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.grey,
                          ),
                          child: Checkbox(
                            activeColor: Theme.of(context).primaryColor,
                            checkColor: Colors.white,
                            value: repository.agreeTerms,
                            onChanged: (newValue) {
                              setState(() {
                                repository.updateAgreeTerms(newValue);
                              });
                            },
                          ),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "I agree with the",
                                style: TextStyle(
                                  fontSize: 10,
                                )),
                            TextSpan(
                                text: " terms and condition",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 11)),
                          ]),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Buttons.coloredButton(
                      context: context,
                      title: "Proceed to payment",
                      onTap: () async {
                        //Navigator.of(context).pushNamed("/paymentpage");
                        repository.couponProceedButton(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
