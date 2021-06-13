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
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xFFFFFFFF).withOpacity(0.9), BlendMode.srcOver),
          ),
        ),
        child: Column(children: [
          Text("FarePrice: 4000", style: TextStyle(color: Colors.red)),
          Text("Do you have a coupon?", style: TextStyle(color: Colors.black)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: TextField(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
              child: Text("Apply Coupon"),
              onPressed: () {},
            ),
          ),
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
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
                child: Text("Proceed to payment"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () => repository.couponProceedButton(context)),
          ),
        ]),
      ),
    );
  }
}
