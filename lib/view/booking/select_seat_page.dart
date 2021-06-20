import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/view/widgets/12_seater_bus.dart';
import 'package:Libmot_Mobile/view/widgets/15_seater_bus.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'passenger_info_page.dart';

class SelectSeatPage extends StatefulWidget {
  final Buses bus;

  SelectSeatPage({@required this.bus});

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  // with AfterLayoutMixin<SelectSeatPage> {
  final String passengerInfo = "/passengerInfomation";

  BookingRepository booking;
  SeatSelectionRepository seatSelection;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void afterFirstLayout(BuildContext context) {
    seatSelection.allSeats.clear();
    seatSelection.selectedSeats.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // booking = Provider.of<BookingRepository>(context);
    // seatSelection = Provider.of<SeatSelectionRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text(
      //     "Select A Seat ",
      //     style: textStyle1,
      //   ),
      //   elevation: 0,
      //   backgroundColor: Color(0xFFFFFFFF).withOpacity(0.9),
      //   leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
      // ),
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(context, 'Select a seat'),

            // (widget.bus.totalNumberOfSeats == 12)
            //     ?
            // TwelveSeaterBus(bus: widget.bus, scaffold: _scaffoldKey)
            //     : FifteenSeaterBus(bus: widget.bus, scaffold: _scaffoldKey),
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
                      SizedBox(height: 5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Image.asset(
                                'images/steering.png',
                                height: 55,
                              ),
                              emptySeat(),
                            ],
                          )),
                          SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.green, 2),
                                SizedBox(width: 12),
                                selectedSeat(Colors.green, 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.grey, 3),
                                SizedBox(width: 12),
                                selectedSeat(Colors.grey, 4),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.green, 5),
                                SizedBox(width: 12),
                                emptySeat(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.grey, 6),
                                SizedBox(width: 12),
                                selectedSeat(Colors.grey, 7),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                emptySeat(),
                                SizedBox(width: 12),
                                selectedSeat(Colors.grey.withOpacity(0.4), 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.grey.withOpacity(0.4), 9),
                                SizedBox(width: 12),
                                selectedSeat(Colors.grey, 10),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                emptySeat(),
                                SizedBox(width: 12),
                                selectedSeat(Colors.green, 11),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.green, 12),
                                SizedBox(width: 12),
                                selectedSeat(Colors.grey.withOpacity(0.4), 13),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                selectedSeat(Colors.green, 14),
                                SizedBox(width: 12),
                                selectedSeat(Colors.grey, 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),

                      Row(
                        children: [
                          blockedSeat(Colors.grey, 'Available'),
                          blockedSeat(Colors.green, 'Selected'),
                          blockedSeat(
                              Colors.grey.withOpacity(0.4), 'Unavailable'),
                        ],
                      ),
                      SizedBox(height: 30),
                      ButtonReusable(
                        onpressed: () async {
                          Get.to(() => PassengerInfoPage());
                        },
                        name: "Continue",
                      ),
                      // ButtonTheme(
                      //   height: 50,
                      //   minWidth: 200,
                      //   child: RaisedButton(
                      //     /// validaion of seats
                      //     onPressed: () {
                      //       //after selecting seat going back proceed button doesnt allow to nexr page
                      //       int numberOfBooking = booking.getBuses.numberOfAdults +
                      //           booking.getBuses.numberOfChildren;
                      //
                      //       if (numberOfBooking != seatSelection.selectedSeats.length) {
                      //         _scaffoldKey.currentState.showSnackBar(
                      //             new SnackBar(content: new Text("$numberOfBooking")));
                      //         print('$numberOfBooking');
                      //         return;
                      //       }
                      //       String guid = "${widget.bus.vehicleTripRegistrationId}:";
                      //       if (numberOfBooking == 1) {
                      //         guid = guid + seatSelection.selectedSeats.first.toString();
                      //       } else {
                      //         for (int i in seatSelection.selectedSeats) {
                      //           guid = (i == seatSelection.selectedSeats.last)
                      //               ? guid + i.toString()
                      //               : guid + i.toString() + ",";
                      //         }
                      //         booking.booking.seatRegistrations = guid;
                      //         booking.booking.routeId = widget.bus.routeId;
                      //       }
                      //       Navigator.of(context).pushNamed(passengerInfo);
                      //     },
                      //     color: Colors.red,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded emptySeat() {
    return Expanded(
      child: Container(),
    );
  }

  selectedSeat(color, seatNumber) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0.5, 0.8),
              spreadRadius: 1,
              blurRadius: 1),
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Seat-1.png',
                  color: color,
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Seat $seatNumber'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  unselectedSeat() {
    return Image.asset(
      'images/Seat.png',
      height: 45,
    );
  }

  blockedSeat(color, title) {
    return Expanded(
      child: Column(
        children: [
          Image.asset(
            'images/Seat-2.png',
            height: 30,
            color: color,
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(title),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
