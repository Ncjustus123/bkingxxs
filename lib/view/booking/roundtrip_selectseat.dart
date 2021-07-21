import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/seat_selection_repository.dart';
import 'package:Libmot_Mobile/widgets/12_roundtrip_seater.dart';
import 'package:Libmot_Mobile/widgets/15_roundtrip_seater.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RoundTripSelectSeatPage extends StatefulWidget {
  final Buses bus;

  RoundTripSelectSeatPage({@required this.bus});

  @override
  _RoundTripSelectSeatPage createState() => _RoundTripSelectSeatPage();
}

class _RoundTripSelectSeatPage extends State<RoundTripSelectSeatPage>
    with AfterLayoutMixin<RoundTripSelectSeatPage> {
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(context, 'Select a seat'),
            (widget.bus.totalNumberOfSeats == 12)
                ? RoundTripTwelveSeaterBus(bus: widget.bus, scaffold: _scaffoldKey)
                : RoundTripFifteenSeaterBus(bus: widget.bus, scaffold: _scaffoldKey),
          ],
        ),
      ),
    );
  }
}
