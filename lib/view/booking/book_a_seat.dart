import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/models/destination_terminal.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:Libmot_Mobile/view/widgets/paymentPaystack.dart';
import 'package:after_layout/after_layout.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';

import '../../repository/booking_repository.dart';
import '../welcome_page.dart';
import 'passenger_info_page.dart';

class BookASeatPage extends StatefulWidget {
  @override
  _BookASeatPageState createState() => _BookASeatPageState();
}

class _BookASeatPageState extends State<BookASeatPage>
    with AfterLayoutMixin<BookASeatPage> {
  final dateController = TextEditingController();

  final adultController = TextEditingController();
  final childrenController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BookingRepository booking;

  @override
  void afterFirstLayout(BuildContext context) {
    booking.getAllRoute();
  }

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    //TODO: show loading screen
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Book A Seat ",
          style: textStyle1,
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFFFFFF).withOpacity(0.9),
        leading: Icon(Icons.arrow_back_rounded, color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Lekki-Ikoyi Link Bridge 1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color(0xFFFFFFFF).withOpacity(0.9), BlendMode.srcOver),
          ),
        ),
        width: _width,
        height: _height,
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
            DropdownWidget(
              booking: booking,
              items: (booking.getRouteModel == null)
                  ? []
                  : booking.getRouteModel.object.items
                      .map((RouteItems route) => route.name)
                      .toList(),
              onchange: (String name) {
                RouteItems route = booking.getRouteModel.object.items
                    .singleWhere((element) => element.name == name);

                booking.getBuses.departureTerminalId = route.id;
                booking.getDestinationTerminals(
                    booking.getBuses.departureTerminalId);
              },
            ),
            DropdownWidget(
              booking: booking,
              items: (booking.destinationTerminalModel == null)
                  ? []
                  : booking.destinationTerminalModel.object
                      .map((DestinationObject object) => object.name)
                      .toList(),
              onchange: (String name) {
                DestinationObject object = booking
                    .destinationTerminalModel.object
                    .singleWhere((element) => element.name == name);
                booking.getBuses.destinationTerminalId = object.id;
              },
            ),
            depatureDateField(context),
            (booking.getBuses.tripType == 1)
                ? arrivalDateField(context)
                : SizedBox(),
            // fromField(adultController),
            // fromField(childrenController),
            SizedBox(height: 20),
            Center(
                child: Text(
              "Travellers",
              style: textStyle1,
            )),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Adult",
                  style: textStyle2,
                ),
                Text(
                  "Child(ren)",
                  style: textStyle2,
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: adulttravellersButton()),
                Expanded(child: booking.childrentravellersButton()),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            proceedButton(context),
          ],
        ),
      ),
    );
  }

  SizedBox proceedButton(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: () {
          //booking.getBuses.numberOfAdults = int.parse(adultController.text);
          //       //booking.getBuses.numberOfChildren = int.parse(childrenController.text);
          //       //TODO;;;; authentication

          //       //booking.getBuses.departureDate = dateController.text.toString();
          booking.searchBuses(_scaffoldKey, context);
        },
        child: Text("Proceed"),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  fromField(controller) {
    return TextFormField(
      controller: controller,
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
    Container adulttravellersButton() {
    return Container(
      height: 50,
      width: 50,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new FloatingActionButton(
            heroTag: null,
            onPressed: booking.addAdult,
              
            
            child: new Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Colors.red,
          ),
          new Text('${booking.getBuses.numberOfAdults}', style: new TextStyle(fontSize: 30.0)),
          new FloatingActionButton(
            heroTag: null,
            onPressed: booking.subtractAdult,
            child: new Icon(
              Icons.horizontal_rule,
              color: Colors.black,
            ),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
