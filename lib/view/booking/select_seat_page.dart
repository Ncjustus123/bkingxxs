import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/seat_selection_repository.dart';
import 'package:Libmot_Mobile/widgets/12_seater_bus.dart';
import 'package:Libmot_Mobile/widgets/15_seater_bus.dart';
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
  buildDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.notifications_active,color: Colors.red,size: 40,),
            new Text("Please Note",style: TextStyle(fontSize: 22),),
          ],
        ),
        content: new Text("Passengers are entitled to have luggage allowance from 0 to 8kg per seat ",
        style: TextStyle(fontSize: 20),),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero).then((_) => buildDialog(context));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.bus);
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
                ? TwelveSeaterBus(bus: widget.bus, scaffold: _scaffoldKey)
                : FifteenSeaterBus(bus: widget.bus, scaffold: _scaffoldKey),
          ],
        ),
      ),
    );
  }
}
