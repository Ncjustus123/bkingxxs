import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/view/widgets/appBar_passenger_info.dart';
import 'package:Libmot_Mobile/view/widgets/paymentPaystack.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 50, 15, 20),
                      margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Booking Confirmed !",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'A confirmation will be sent to provided contact.',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              Text(
                                booking.getBusesResponseModel.object
                                    .departures[0].routeName,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Date",
                                          style: confirmationTextsstyle,
                                        ),
                                        Text(booking.getBuses.departureDate),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Trip time",
                                          style: confirmationTextsstyle,
                                        ),
                                        Text(booking
                                            .getBusesResponseModel
                                            .object
                                            .departures[0]
                                            .departureTime),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text("Name of Traveller",
                                            style: confirmationTextsstyle),
                                        Text(
                                          '${booking.booking.firstName.toString().toUpperCase()} ${booking.booking.lastName.toString().toUpperCase()}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text("No.of Travellers",
                                          style: confirmationTextsstyle),
                                      Text(booking.totalTravellers.toString()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text("Trip fare",
                                          style: confirmationTextsstyle),
                                      Text(
                                        '\u20A6${booking.totalestimate.toString()}',
                                        style:
                                            TextStyle(fontFamily: 'Monserrat'),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Booking Status",
                                          style: confirmationTextsstyle,
                                        ),
                                        Text(booking.postBookingResponse.object
                                            .response),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Booking Refrence",
                                          style: confirmationTextsstyle,
                                        ),
                                        Text(booking.postBookingResponse.object
                                            .bookingReferenceCode),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    "For further enquiries, please call our customer care line on ",
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: "08154757464",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print("tapp");
                                          launch("tel://08154757464");
                                          //_makePhoneCall("tel://08154757464");

                                          // navigate to desired screen
                                        }),
                                  TextSpan(text: " or email us on "),
                                  TextSpan(
                                      text: "info@libmot.com",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>Get.to(PaymentPaystack()),
                                        
                                          // navigate to desired screen
                                        ),
                                ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Thank you for booking your trip with Libmot.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 12),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(onPressed: () {}, child: Text("Done")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey.withOpacity(0.6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 150),
                child: Row(
                  children: [
                    smallContainer(),
                    Expanded(
                        child: Container(
                      height: 0.6,
                      color: Colors.grey,
                    )),
                    smallContainer(),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(color: Colors.white, width: 4)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(Icons.check, color: Colors.white, size: 25),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

class smallContainer extends StatelessWidget {
  const smallContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }
}
