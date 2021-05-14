import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FifteenSeaterBus extends StatelessWidget {
  Buses bus;
  dynamic scaffold;
  FifteenSeaterBus({this.bus, this.scaffold});

  BookingRepository booking;
  SeatSelectionRepository seatSelection;


  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    seatSelection = Provider.of<SeatSelectionRepository>(context);
    seatSelection.initialSetUp(bus);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[50],
          boxShadow: [BoxShadow(color: Colors.grey, spreadRadius: 3)]),
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
      height: 400,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Image.asset(
                'images/steering.png',
                height: 45,
              ),
              Spacer(),
              seat(2),
              buildSizedBox(),
              seat(1),
            ],
          ),
          Row(
            children: [
              seat(3),
              buildSizedBox(),
              seat(4),
              buildSizedBox(),
              seat(5),
              Spacer(),
            ],
          ),
          Row(
            children: [
              seat(6),
              buildSizedBox(),
              seat(7),
              Spacer(),
              seat(8),
            ],
          ),
          Row(
            children: [
              seat(9),
              buildSizedBox(),
              seat(10),
              Spacer(),
              seat(11),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              seat(12),
              buildSizedBox(),
              seat(13),
              buildSizedBox(),
              seat(14),
              buildSizedBox(),
              seat(15),
            ],
          ),
        ],
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
        stackImage = blockedSeat();
        break;
      case SeatStatus.selected:
        stackImage = selectedSeat();
        break;
      default:
        stackImage = unselectedSeat();
        break;
    }

    return GestureDetector(
      onTap: () {
        if (seatObject.status == SeatStatus.unSelected) {
          int numberOfBooknings =
              booking.model.numberOfAdults + booking.model.numberOfChildren;

          if (numberOfBooknings <= seatSelection.selectedSeats.length) {
            scaffold.currentState.showSnackBar(
                new SnackBar(content: new Text("$numberOfBooknings")));
            print('$numberOfBooknings');
            return;
          }else{
            
          }

          seatSelection.selectSeat(seatObject);
        } else if (seatObject.status == SeatStatus.selected) {
          seatSelection.unselectSeat(i, seatIndex);
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          stackImage,
          Text(
            i.toString(),
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }

  selectedSeat() {
    return Image.asset(
      'images/selected_seat.png',
      height: 45,
    );
  }

  unselectedSeat() {
    return Image.asset(
      'images/unselected_seat.png',
      height: 45,
    );
  }

  blockedSeat() {
    return Image.asset(
      'images/blocked_seat.png',
      height: 45,
    );
  }
}
