import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Center(child: Text("Boooking Confirmed")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Thanks for booking your trip with libmot A confirmation will be sent to provided contact."),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                //mainAxisAlignment : MainAxisAlignment.spaceBetween,
                children: [
                  Text("Booking Number :"),
                  SizedBox(width: 10),
                  Text("Booking Number"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 5.0, bottom: 0.0, right: 250.0),
              child: Text("Trip Details"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 5.0, bottom: 0.0, right: 250.0),
              child: Text("Okota ==> ejigbo"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text("Trip time :"),
                  SizedBox(width: 10),
                  Text("Booking Number"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  " For further enquiries, please call our customer care line on 09062547033 or email us on info@libmot.com"),
            ),
            Spacer(),
            ButtonTheme(
              height: 50,
              minWidth: 200,
              child: ElevatedButton(
                child: Text("done"),
                onPressed: () {},
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
