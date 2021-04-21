import 'package:flutter/material.dart';

class ApplyCoupon extends StatefulWidget {
  @override
  _ApplyCouponState createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Apply Coupon",),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Text("FarePrice:4000", style: TextStyle(color: Colors.red)),
        Text("Do you have a coupon ?", style: TextStyle(color: Colors.black)),
        TextField(),
        ElevatedButton(child: Text("data"), onPressed: () {}),
        Row(
          children: [
            Checkbox(
                value: checkValue,
                onChanged: (newValue) => {
                      setState(() {
                        checkValue = newValue;
                      }),
                    }),
            Text("i agree to", style: TextStyle(color: Colors.red)),
          ],
        ),
        ElevatedButton(child: Text("data"), onPressed: () {}),
      ]),
    );
  }
}
