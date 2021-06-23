import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/view/booking/passenger_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TwelveSeaterBus extends StatelessWidget {
  Buses bus;
  dynamic scaffold;
  TwelveSeaterBus({this.bus, this.scaffold});

  BookingRepository booking;
  SeatSelectionRepository seatSelection;

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    seatSelection = Provider.of<SeatSelectionRepository>(context);
    seatSelection.initialSetUp(bus);
    return Expanded(
          child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(45))),
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
                        // seat(2),
                        SizedBox(width: 12),
                        // seat(1),
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
                        // seat(3),
                        SizedBox(width: 12),
                        // seat(4),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        // seat(5),
                        SizedBox(width: 12),
                        // emptySeat(),
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
                        // seat(6),
                        SizedBox(width: 12),
                        // seat(7),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        // emptySeat(),
                        SizedBox(width: 12),
                        // seat(8),
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
                        // seat(9),
                        SizedBox(width: 12),
                        // seat(10),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      children: [
                        // emptySeat(),
                        SizedBox(width: 12),
                        // seat(11),
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
                        // seat(12),
                        SizedBox(width: 12),
                        // seat(13),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  // Expanded(
                  //   child: Row(
                  //     children: [
                  //       seat(14),
                  //       SizedBox(width: 12),
                  //      seat(15),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 30),

              Row(
                children: [
                  blockedSeat(Colors.grey, 'Available'),
                  blockedSeat(Colors.green, 'Selected'),
                  blockedSeat(Colors.grey.withOpacity(0.4), 'Unavailable'),
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
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      width: 30,
    );
  }

  Widget seat(int i) {
    Widget stackImage;

    //searchThrough the excluded list;

    int seatIndex =
        seatSelection.allSeats.indexWhere((element) => i == element.seatNumber);
    SeatObject seatObject = seatSelection.allSeats[seatIndex];

    switch (seatObject.status) {
      case SeatStatus.blocked:
        stackImage = selectedSeat(Colors.grey, i.toString());
        break;
      case SeatStatus.selected:
        stackImage = selectedSeat(Colors.green, i.toString());
        break;
      default:
        stackImage = selectedSeat(Colors.grey.withOpacity(0.4), i.toString());
        break;
    }

    return GestureDetector(
      onTap: () {
        if (seatObject.status == SeatStatus.unSelected) {
          int numberOfBooknings = booking.getBuses.numberOfAdults +
              booking.getBuses.numberOfChildren;

          if (numberOfBooknings <= seatSelection.selectedSeats.length) {
            scaffold.currentState.showSnackBar(
                new SnackBar(content: new Text("$numberOfBooknings")));
            print('$numberOfBooknings');

            return;
          }

          seatSelection.selectSeat(seatObject);
        } else if (seatObject.status == SeatStatus.selected) {
          seatSelection.unselectSeat(i, seatIndex);
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Row(
            children: [
              stackImage,
            ],
          ),
          Text(
            i.toString(),
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
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
