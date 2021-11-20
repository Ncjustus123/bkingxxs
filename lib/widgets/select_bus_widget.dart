import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:flutter/material.dart';

class SelectBus extends StatelessWidget {
  final String selectSeat = "/selectSeats";
  final index;
  final Buses bus;
  final int noOfChildren;
  final int tripType;
  BookingRepository booking;

  SelectBus({this.index, this.bus, this.noOfChildren, this.tripType});

  @override
  Widget build(BuildContext context) {
   //
    // booking.bus = bus.vehicleName;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(selectSeat, arguments: bus);
        },
        child: Card(
          elevation: 1,
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
                                style: TextStyle(color: Theme.of(context).hintColor,
                                    decorationColor: Colors.red,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: " Terminal",
                                style: TextStyle(color: Theme.of(context).hintColor,
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
                                style: TextStyle(color: Theme.of(context).hintColor,
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                            TextSpan(
                                text: " per adult",
                                style: TextStyle(fontSize: 11,color: Theme.of(context).hintColor)),
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
                                          fontSize: 15,color: Theme.of(context).hintColor,
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: " per child",
                                      style: TextStyle(color: Theme.of(context).hintColor,fontSize: 11)),
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
                              Navigator.of(context)
                                  .pushNamed(selectSeat, arguments: bus);
                            },
                            child: Text("view seat(s)",style: TextStyle(color:Colors.white),),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Theme.of(context).primaryColor),
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
