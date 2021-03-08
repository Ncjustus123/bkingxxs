import 'package:Libmot_Mobile/models/destination_terminal.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../repository/booking_repository.dart';

class BookASeatPage extends StatefulWidget {
  @override
  _BookASeatPageState createState() => _BookASeatPageState();
}

class _BookASeatPageState extends State<BookASeatPage> {
  final dateController = TextEditingController();

  final passenger = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BookingRepository booking;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    booking.getAllRoute();

    //TODO: show loading screen
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  DefaultTabController(
                    length: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TabBar(
                        indicator: BubbleTabIndicator(
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            indicatorHeight: 35,
                            indicatorColor: Colors.red),
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Text("oneway"),
                          Text("round trip"),
                        ],
                        onTap: (index) {
                          print('$index');
                         // booking.getBuses.tripType = index;
                          booking.tripTypeChange(index);
                        },
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    items: (booking.getRouteModel == null)
                        ? []
                        : booking.getRouteModel.object.items
                            .map((RouteItems route) {
                            return DropdownMenuItem<String>(
                              child: Text(route.name),
                              value: route.id.toString(),
                            );
                          }).toList(),
                    onChanged: (String id) {
                      booking.getBuses.departureTerminalId = int.parse(id);
                      booking.getDestinationTerminals(
                          booking.getBuses.departureTerminalId);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    items: (booking.destinationTerminalModel == null)
                        ? []
                        : booking.destinationTerminalModel.object
                            .map((DestinationObject object) {
                            return DropdownMenuItem<String>(
                              child: Text(object.name),
                              value: object.id.toString(),
                            );
                          }).toList(),
                    onChanged: (String id) {
                      booking.getBuses.destinationTerminalId = int.tryParse(id);
                    },
                  ),
                  depatureDateField(context),
                  (booking.getBuses.tripType == 1)
                    ?  arrivalDateField(context)
                      : SizedBox(),
                  fromField(),
                  proceedButton(context),
                ],
              )),
        ));
  }

   FlatButton proceedButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        booking.getBuses.numberOfAdults = int.parse(passenger.text);
        //booking.getBuses.departureDate = dateController.text.toString();
        booking.searchBuses(_scaffoldKey, context);
      },
      child: const Text(
        "Proceed",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.red,
    );
  }

  fromField() {
    return TextFormField(
      controller: passenger,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please input a departure address';
        }
        return null;
      },
    );
  }

  depatureDateField(context) {
    return TextFormField(
      readOnly: true,
      controller: dateController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select departure date';
        }
        return null;
      },
      onTap: () async {
        DateTime selectedTime = await booking.showDate(context);

        dateController.text = '${DateFormat('yMMMd').format(selectedTime)}';
        booking.getBuses.departureDate =
            "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
      },
    );
  }

  arrivalDateField(context) {
    return TextFormField(
      readOnly: true,
      controller: dateController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please select departure date';
        }
        return null;
      },
      onTap: () async {
        DateTime selectedTime = await booking.showDate(context);

        dateController.text = '${DateFormat('yMMMd').format(selectedTime)}';
        booking.getBuses.departureDate =
            "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
      },
    );
  }
}
