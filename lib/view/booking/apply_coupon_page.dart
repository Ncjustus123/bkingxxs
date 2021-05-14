import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/coupon_repository.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Apply Coupon",
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Text("FarePrice: 4000", style: TextStyle(color: Colors.red)),
        Text("Do you have a coupon?", style: TextStyle(color: Colors.black)),
        TextField(),
        RaisedButton(child: Text("Apply Coupon"), onPressed: () {}),
        Row(
          children: [
            Checkbox(
                value: repository.agreeTerms,
                onChanged: (newValue) => {
                      setState(() {
                        repository.updateAgreeTerms(newValue);
                      }),
                    }),
            Text("I agree to", style: TextStyle(color: Colors.red)),
          ],
        ),
        RaisedButton(
            child: Text("Proceed to payment"),
            onPressed: () => repository.couponProceedButton(context)),
      ]),
    );
  }
}
