import 'package:flutter/material.dart';

class BookingConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Booking Confirmed"),
            Text(
                "Thank you for booking your trip with Libmot. A confirmation will be sent to provided contact."),
            Container(
              color: Colors.transparent,
              height: 50,
              child: Column(
                children: [
                  customWrap("Booking Number", ""),
                  customWrap("Booking Date", ""),
                  customWrap("Booking Status", ""),
                  customWrap("Trip Fare", ""),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
                child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text("Trip Details"),
                      Text("Lagos - Abuja"),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      customWrap("Trip Time", ""),
                      customWrap("Trip Date", ""),
                      customWrap("Passenger", ""),
                    ],
                  ),
                ),
              ],
            )),
            Text(
                "For further enquiries, please call our customer care line on 08154757464 or email us on info@libmot.com"),
            ElevatedButton(onPressed: () {}, child: Text("Done")),
          ],
        ),
      )),
    );
  }

  Widget customWrap(String title, String value) {
    return Wrap(
      children: [
        Text("$title: "),
        Text(value),
      ],
    );
  }
}
