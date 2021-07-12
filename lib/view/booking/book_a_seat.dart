import 'package:Libmot_Mobile/Reusables/bottom_sheet.dart';
import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/models/destination_terminal.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:after_layout/after_layout.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../repository/booking_repository.dart';

class BookASeatPage extends StatefulWidget {
  @override
  _BookASeatPageState createState() => _BookASeatPageState();
}

class _BookASeatPageState extends State<BookASeatPage>
    with AfterLayoutMixin<BookASeatPage> {
  String direction;
  final adultController = TextEditingController();
  final childrenController = TextEditingController();
  TextEditingController arrivaldateController = TextEditingController();
  TextEditingController depatureController = TextEditingController();
  TextEditingController departuredateController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BookingRepository booking;
  List<String> arrivalOptions;
  List<String> departureOptions;
  List<int> departureIds;
  List<int> arrivalIds;
  int indexOfRoute = 0;
  String tripOption = 'One Way';
  String selectedFrom = '';
  String selectedTo = '';
  int departureId;
  int arrivalId;

  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    departureOptions = (booking.getRouteModel == null)
        ? []
        : booking.getRouteModel.object.items
            .map(
              (RouteItems route) => route.name,
            )
            .toList();
    departureIds = (booking.getRouteModel == null)
        ? []
        : booking.getRouteModel.object.items
            .map(
              (RouteItems route) => route.id,
            )
            .toList();
    arrivalIds = (booking.destinationTerminalModel == null)
        ? []
        : booking.destinationTerminalModel.object
            .map(
              (DestinationObject object) => object.id,
            )
            .toList();
    arrivalOptions = (booking.destinationTerminalModel == null)
        ? []
        : booking.destinationTerminalModel.object
            .map((DestinationObject object) => object.name)
            .toList();
    //TODO: show loading screen
    print(booking.getBuses.numberOfChildren);
    print(booking.getBuses.numberOfAdults);
    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          width: _width,
          height: _height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          // border: Border.all(width: 0.8, color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.west,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      indexOfRoute == 0
                          ? 'One-way Trip Booking'
                          : 'Round Trip Booking',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(width: 35),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: TabBar(
                      indicator: BubbleTabIndicator(
                          tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          indicatorHeight: 45,
                          indicatorRadius: 35,
                          indicatorColor: Theme.of(context).primaryColor),
                      labelStyle: TextStyle(
                        fontSize: 15,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Theme.of(context).primaryColor,
                      tabs: [
                        Text("One Way"),
                        Text("Round Trip"),
                      ],
                      onTap: (index) {
                        print('$index');
                        setState(() {
                          indexOfRoute = index;
                          booking.triptype = indexOfRoute;
                          print('triptype');
                          print(booking.triptype);
                        });
                        booking.getBuses.tripType = index ?? 0 ;
                        booking.tripTypeChange(index);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(23.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                direction = 'from';
                              });
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SingleChildScrollView(
                                    child: bottomRouteSheet(context)),
                              );
                            },
                            child: InputFormField(
                              suffixIcon: Icon(Icons.place),
                              label: 'From',
                              keyboardType: null,
                              enabled: false,
                              controller: depatureController,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                direction = 'to';
                              });
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SingleChildScrollView(
                                    child: bottomRouteSheet(context)),
                              );
                            },
                            child: InputFormField(
                              suffixIcon: Icon(Icons.place),
                              label: 'To',
                              enabled: false,
                              controller: arrivalController,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime selectedTime =
                                  await booking.showDate(context);
                              if (selectedTime != null) {
                                departuredateController.text =
                                    '${DateFormat('yMMMd').format(selectedTime)}';
                                booking.getBuses.departureDate =
                                    "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
                              }
                            },
                            child: InputFormField(
                              enabled: false,
                              controller: departuredateController,
                              suffixIcon: Icon(Icons.event_note),
                              label: 'Departure Date',
                            ),
                          ),
                          indexOfRoute == 0
                              ? SizedBox()
                              : InkWell(
                                  onTap: () async {
                                    DateTime selectedTime =
                                        await booking.showDate(context);
                                    if (selectedTime != null) {
                                      arrivaldateController.text =
                                          '${DateFormat('yMMMd').format(selectedTime)}';
                                      booking.getBuses.returnDate =
                                          "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
                                    }
                                  },
                                  child: InputFormField(
                                    enabled: false,
                                    controller: arrivaldateController,
                                    suffixIcon: Icon(Icons.event_note),
                                    label: 'Arrival Date',
                                  ),
                                ),
                          Text(
                            "Travellers",
                            style: textStyle1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Adult(s)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Expanded(
                                        child: Text(
                                      booking.getBuses.numberOfAdults
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Child(ren)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Expanded(
                                        child: Text(
                                      booking.getBuses.numberOfChildren
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Buttons.whiteButton(
                            context: context,
                            title: 'Select Travellers',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) =>
                                    SingleChildScrollView(child: BottomCard()),
                              );
                            },
                          ),
                          SizedBox(height: 25),
                          (booking.getBuses.numberOfAdults.toString() == '0' &&
                                  booking.getBuses.numberOfChildren
                                          .toString() ==
                                      '0')
                              ? Container()
                              : ButtonReusable(
                                  onpressed: () async {
                                    booking.getBuses.departureDate =
                                        departuredateController.text.toString();
                                    booking.getBuses.departureTerminalId =
                                        departureId;
                                    booking.getBuses.destinationTerminalId =
                                        arrivalId;
                                    booking.searchBuses(_scaffoldKey, context);
                                    //Get.to(() => SelectBusPage());
                                  },
                                  name: "Search",
                                ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomRouteSheet(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);

    //int index = booking.getRouteModel.object.items.length;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    //int type;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: _height * 0.6,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: buildDropList(),
    );
  }

  buildDropList() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              direction == 'from' ? 'Departure location' : 'Arrival location',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: Column(
                  children: List<Widget>.generate(
                      direction == 'from'
                          ? departureOptions.length
                          : arrivalOptions.length, (index) {
                    return new ListTile(
                      onTap: () {
                        direction == 'from'
                            ? selectFromOption(
                                departureOptions[index], departureIds[index])
                            : selectToOption(
                                arrivalOptions[index], arrivalIds[index]);
                      },
                      title: Text(
                        direction == 'from'
                            ? departureOptions[index]
                            : arrivalOptions[index],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: direction == 'from'
                              ? selectedFrom == departureOptions[index]
                                  ? FontWeight.w600
                                  : FontWeight.w500
                              : selectedTo == arrivalOptions[index]
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                        ),
                      ),
                      trailing: direction == 'from'
                          ? selectedFrom == departureOptions[index]
                              ? Icon(Icons.check,
                                  size: 15,
                                  color: Theme.of(context).primaryColor)
                              : Text('')
                          : selectedTo == arrivalOptions[index]
                              ? Icon(Icons.check,
                                  size: 15,
                                  color: Theme.of(context).primaryColor)
                              : Text(''),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectFromOption(String option, id) {
    setState(() {
      selectedFrom = option;
      depatureController.text = selectedFrom;
      departureId = id;
    });
    booking.getDestinationTerminals(departureId);
    print('depatureId' + departureId.toString());
    Get.back();
  }

  void selectToOption(String option, id) {
    setState(() {
      selectedTo = option;
      arrivalController.text = selectedTo;
      arrivalId = id;
    });
    Get.back();
    print("arrivalId" + arrivalId.toString());
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    booking.getAllRoute();
  }
}
