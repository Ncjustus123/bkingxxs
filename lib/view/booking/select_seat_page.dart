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

class _SelectSeatPageState extends State<SelectSeatPage> with AfterLayoutMixin<SelectSeatPage>{

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
            TwelveSeaterBus(bus: widget.bus, scaffold: _scaffoldKey),

            // (widget.bus.totalNumberOfSeats == 12)
            //     ?
            // TwelveSeaterBus(bus: widget.bus, scaffold: _scaffoldKey)
            //     : FifteenSeaterBus(bus: widget.bus, scaffold: _scaffoldKey),
            
          ],
        ),
      ),
    );
  }

}