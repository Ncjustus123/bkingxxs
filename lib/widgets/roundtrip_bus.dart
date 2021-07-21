import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:flutter/material.dart';

class RoundTripBus extends StatelessWidget {
  final String roundTripselectSeat = "/roundTripselectSeats";
  final index;
  final Buses bus;
  final int noOfChildren;
  final int tripType;
  BookingRepository booking;

  RoundTripBus({this.index, this.bus, this.noOfChildren, this.tripType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(roundTripselectSeat, arguments: bus);
        },
        child: Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        bus.routeName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.3,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: Offset(0.3, 0.4))
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Departure Time: ${bus.departureTime}",
                        textAlign: TextAlign.center,
                        style: textStyle2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (bus.vehicleName == "Toyota (Business Class)")
                            ? Image.asset(
                                'images/haice_2020.png',
                                height: 75,
                              )
                            : Image.asset(
                                'images/bus_image.png',
                                height: 70,
                              ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${bus.vehicleName} hiace | AC",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(
                                  width: 0.3,
                                  color: Colors.grey.withOpacity(0.4))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text(
                              "${bus.availableNumberOfSeats} available seat(s)",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 50),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "${getNairaSign()}${bus.farePrice}",
                                style: TextStyle(
                                    color: Colors.black,
                                    decorationColor: Colors.red,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: " Terminal",
                                style: TextStyle(
                                    color: Colors.black,
                                    decorationColor: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 12)),
                          ])),
                          // Text(
                          //   "₦${bus.farePrice}\n Terminal",
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.w500,
                          //       fontFamily: 'Monserrat',
                          //       decoration: TextDecoration.lineThrough,
                          //       decorationColor: Colors.red),
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 50),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "${getNairaSign()}${bus.adultFare}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: " per adult",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11)),
                          ])),

                          // Text(
                          //   "${getNairaSign()}${bus.adultFare}\n per Adult",
                          //   style: textStyle2,
                          // ),
                        ),
                        (noOfChildren > 0)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5, left: 50),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "${getNairaSign()}${bus.childFare}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: " per child",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 11)),
                                ])),
                                // Text(
                                //   "${getNairaSign()}${bus.childFare}\n per child",
                                //   style: textStyle2,
                                // ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              ///Get.to(() => SelectSeatPage());
                              Navigator.of(context)
                                  .pushNamed(roundTripselectSeat, arguments: bus);
                            },
                            child: Text("view seat(s)"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
