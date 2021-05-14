
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/repository/seat_selection_repository.dart';
import 'package:Libmot_Mobile/view/widgets/12_seater_bus.dart';
import 'package:Libmot_Mobile/view/widgets/15_seater_bus.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectSeatPage extends StatefulWidget {
  final Buses bus;

  SelectSeatPage({@required this.bus});

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage>
    with AfterLayoutMixin<SelectSeatPage> {
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
    booking = Provider.of<BookingRepository>(context);
    seatSelection = Provider.of<SeatSelectionRepository>(context);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            (widget.bus.totalNumberOfSeats == 12)
                ? TwelveSeaterBus(bus: widget.bus, scaffold: _scaffoldKey)
                : FifteenSeaterBus(bus: widget.bus, scaffold: _scaffoldKey),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 90, right: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  selectedSeat(),
                  unselectedSeat(),
                  blockedSeat(),
                ],
              ),
            ),
            SizedBox(height: 50),
            ButtonTheme(
              height: 50,
              minWidth: 200,
              child: RaisedButton(
                /// validaion of seats
                onPressed: () {
                  int numberOfBooking = booking.model.numberOfAdults +
                      booking.model.numberOfChildren;

                  if (numberOfBooking != seatSelection.selectedSeats.length) {
                    _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(content: new Text("$numberOfBooking")));
                    print('$numberOfBooking');
                    return;
                  }
                  String guid = "${widget.bus.vehicleTripRegistrationId}:";
                  if (numberOfBooking == 1) {
                    guid = guid + seatSelection.selectedSeats.first.toString();
                  } else {
                    for (int i in seatSelection.selectedSeats) {
                      guid = (i == seatSelection.selectedSeats.last)
                          ? guid + i.toString()
                          : guid + i.toString() + ",";
                    }
                    booking.booking.seatRegistrations = guid;
                    booking.booking.routeId = widget.bus.routeId;
                  }
                  Navigator.of(context).pushNamed(passengerInfo);
                },
                color: Colors.red,
              ),
            ),
          ],
        ),
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
