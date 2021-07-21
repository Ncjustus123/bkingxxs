import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:Libmot_Mobile/Reusables/appBar_passenger_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingConfirmation extends StatefulWidget {
  @override
  _BookingConfirmationState createState() => _BookingConfirmationState();
}

class _BookingConfirmationState extends State<BookingConfirmation> {
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Color(0xFF85000D) : Colors.grey,
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
                        color: Get.isDarkMode
                            ? Colors.grey.shade900
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Booking Confirmed !",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
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
                                        Text(booking.departureSelectedBus
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
                          Text("For further enquiries, please call our  "),
                          Row(
                            children: [
                              Text("customer care line on"),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                child: Text(
                                  "08154757464",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onTap: () {
                                  launch("tel://08154757464");
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(" or email us on "),
                              GestureDetector(
                                  onTap: () {
                                    launch(
                                        'mailto:info@libmot.com?subject=Complaint%20Email&body=Complaint%20');
                                  },
                                  child: Text(
                                    "info@libmot.com",
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
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
                          ElevatedButton(
                            onPressed: () {
                              int count = 0;
                              Navigator.popUntil(context, (route) {
                                return count++ == 9;
                              });
                              setState(() {});
                            },
                            child: Text("Done",
                                style: TextStyle(
                                    color: MyThemes.darkTheme != null
                                        ? Colors.white
                                        : Colors.black)),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                          ),
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
                      color: Get.isDarkMode ? Color(0xFF85000D) : Colors.grey,
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
        color: Get.isDarkMode ? Color(0xFF85000D) : Colors.grey,
      ),
    );
  }
}
