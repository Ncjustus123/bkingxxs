import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/view/booking/passenger_info_page.dart';
import 'package:Libmot_Mobile/view/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RoundTripTwelveSeaterBus extends StatelessWidget {
  Buses bus;
  dynamic scaffold;
  final String busSearch = "/selectBus";
  RoundTripTwelveSeaterBus({this.bus, this.scaffold});

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
                    child: Image.asset('images/steering.png', height: 55),
                  ),
                  SizedBox(width: 12),
                  emptySeat(),
                  SizedBox(width: 45),
                  Expanded(child: seat(1)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: seat(2)),
                  SizedBox(width: 12),
                  Expanded(child: seat(3)),
                  SizedBox(width: 45),
                  emptySeat(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: seat(4)),
                  SizedBox(width: 12),
                  Expanded(child: seat(5)),
                  SizedBox(width: 45),
                  Expanded(child: seat(6)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: seat(7)),
                  SizedBox(width: 12),
                  Expanded(child: seat(8)),
                  SizedBox(width: 45),
                  Expanded(child: seat(9)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: seat(10)),
                  SizedBox(width: 12),
                  Expanded(child: seat(11)),
                  SizedBox(width: 45),
                  Expanded(child: seat(12)),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  blockedSeat(Colors.grey[800], 'Available'),
                  blockedSeat(Colors.green, 'Selected'),
                  blockedSeat(Colors.grey.withOpacity(0.4), 'Unavailable'),
                ],
              ),
              SizedBox(height: 30),
              ButtonReusable(
                onpressed: () async {
                  int numberOfBooking = booking.getBuses.numberOfAdults +
                      booking.getBuses.numberOfChildren;
                  if (numberOfBooking != seatSelection.selectedSeats.length) {
                    Dialogs.showErrorSnackBar(
                        'Oops!', " You must select $numberOfBooking  Seat(s)");
                    print('$numberOfBooking');
                    return;
                  }
                  String guid = "${bus.vehicleTripRegistrationId}:";
                  if (numberOfBooking == 1) {
                    guid = guid + seatSelection.selectedSeats.first.toString();
                  } else {
                    for (int i in seatSelection.selectedSeats) {
                      guid = (i == seatSelection.selectedSeats.last)
                          ? guid + i.toString()
                          : guid + i.toString() + ",";
                    }
                    booking.booking.seatRegistrations = guid;
                    booking.booking.routeId = bus.routeId;
                  }
                  Get.to(() => PassengerInfoPage());
                },
                name: "Continue",
              ),
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
        stackImage = selectedSeat(Colors.grey.withOpacity(0.4), i.toString());
        break;
      case SeatStatus.selected:
        stackImage = selectedSeat(Colors.green, i.toString());
        break;
      default:
        stackImage = selectedSeat(Colors.grey[800], i.toString());
        break;
    }

    return GestureDetector(
      onTap: () {
        if (seatObject.status == SeatStatus.unSelected) {
          int numberOfBookings = booking.getBuses.numberOfAdults +
              booking.getBuses.numberOfChildren;

          if (numberOfBookings <= seatSelection.selectedSeats.length) {
            Dialogs.showErrorSnackBar('Oops!',
                " You cant select more than $numberOfBookings Seat(s)");
            // s
            print('$numberOfBookings');

            return;
          }

          seatSelection.selectSeat(seatObject);
        } else if (seatObject.status == SeatStatus.selected) {
          seatSelection.unselectSeat(i, seatIndex);
        }
      },
      child: stackImage,
    );
  }

  Expanded emptySeat() {
    return Expanded(
      child: Container(),
    );
  }

  selectedSeat(color, seatNumber) {
    return Container(
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
                child: Text("Seat $seatNumber"),
              ),
            ],
          ),
        ),
      ),
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
