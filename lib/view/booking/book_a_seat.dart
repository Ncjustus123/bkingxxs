import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/models/destination_terminal.dart';
import 'package:Libmot_Mobile/models/get_route.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/view/booking/select_passanger.dart';
import 'package:after_layout/after_layout.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/booking_repository.dart';

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
  List<String> arrivalOptionsnysc;
  List<String> generalArrivalOptions;
  List<String> departureOptions;
  List<int> departureIds;
  List<String> allArrivals;
  List<String> departureList;
  List<int> allArrivalIds;
  int indexOfRoute = 0;
  String tripOption = 'One Way';
  String selectedFrom = '';
  String selectedTo = '';
  int departureId;
  int arrivalId;

  String nyscOption;


  @override
  void initState() {
    var arg = Get.arguments;
    print(arg);
    setState(() {
      nyscOption = arg["nyscOption"];
    });

    //
    super.initState();
  }


  var newDepature;
  boot(context) {
    booking = Provider.of<BookingRepository>(context);
    // departureList = (booking.getRouteModel == null)
    //     ? []
    //     : booking.getRouteModel.object.items
    //         .map(
    //           (RouteItems route) => route.name,
    //         )
    //         .toList();
    departureItems = (booking.getRouteModel == null)
        ? []
        : booking.getRouteModel.object.items.toList();
    newDepature = departureItems .where((i) => !i.name.toString().toLowerCase().contains('nysc') && i.name != null)
        .toList();

    arrivalItems = booking.generalarrivalList;
    nyscArrivalItems = booking.newArrivalList;




    // print('departureList');
    // print(departure);
    //
    // departureOptions = departureList
    //     .where((i) => !i.toString().toLowerCase().contains("nysc") || i == null)
    //     .toList();
    // print('departureList');
    // print(departureList);
    // departureIds = (booking.getRouteModel == null)
    //     ? []
    //     : booking.getRouteModel.object.items
    //         .map(
    //           (RouteItems route) => route.id,
    //         )
    //         .toList();

    // allArrivalIds = (booking.destinationTerminalModel == null)
    //     ? []
    //     : booking.destinationTerminalModel.object
    //         .map(
    //           (DestinationObject object) => object.id,
    //         )
    //         .toList();
    // arrivalOptions = (booking.destinationTerminalModel == null)
    //     ? []
    //     : booking.destinationTerminalModel.object
    //         .map((DestinationObject object) => object.name)
    //         .toList();
    // print('arrivalList');
    // print(arrivalOptions);
    // arrivalOptionsnysc = arrivalOptions
    //     .where((i) => i.toString().toLowerCase().contains("nysc") || i == null)
    //     .toList();
    // print('arrivalOptions');
    // print(arrivalOptions);
    // print('arrivalOptionsnysc');
    // print(arrivalOptionsnysc);
    // generalArrivalOptions = arrivalOptions
    //     .where((i) => !i.toString().toLowerCase().contains("nysc") || i == null)
    //     .toList();
    // print('generalArrivalOptions');
    // print(generalArrivalOptions);
  }


  @override
  Widget build(BuildContext context) {
    boot(context);
    // booking = Provider.of<BookingRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

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
                        setState(() {
                          indexOfRoute = index;
                          booking.triptype = indexOfRoute;
                          booking.getBuses.tripType = indexOfRoute;
                          print('triptype');
                          print(booking.triptype);
                        });
                        // booking.getBuses.tripType = index ?? 0 ;
                        // booking.tripTypeChange(index);
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
                                  child: bottomRouteSheet(context),
                                ),
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
                                isDismissible: false,
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
                              : Buttons.coloredButton(
                                  context: context,
                                  title: "Search",
                                  onTap: () async {
                                    booking.getBuses.departureDate =
                                        departuredateController.text.toString();
                                    booking.getBuses.departureTerminalId =
                                        departureId;
                                    booking.getBuses.destinationTerminalId =
                                        arrivalId;

                                    if (depatureController.text == '') {
                                      Dialogs.showErrorSnackBar('Error!',
                                          'Select a departure terminal');
                                    } else
                                      searchBus();
                                  }),
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

  searchBus() {
    if (arrivalController.text == '')
      Dialogs.showErrorSnackBar('Error!', 'Select a arrival terminal');
    else if (departuredateController.text == '')
      Dialogs.showErrorSnackBar('Error!', 'Select a departure date');
    else if (indexOfRoute != 0 && arrivaldateController.text == '')
      Dialogs.showErrorSnackBar('Error!', 'Select a arrival date');
    else {
      booking.searchBuses(_scaffoldKey, context);
      booking.getBuses.toJson();
    }
  }

  var departureItems=[];
  var arrivalItems=[];
  var nyscArrivalItems=[];

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
                  children: List<Widget>.generate(  //departureItems.length
                      direction == 'from'
                          ? departureItems.length
                          : nyscOption == 'general'
                              ? arrivalItems.length
                              : arrivalItems.length, (index) {
                    return new ListTile(
                      onTap: () {
                        direction == 'from'
                            ? selectFromOption(departureItems[index])
                            : selectToOption(
                                nyscOption == 'general'
                                    ? arrivalItems[index]
                                    : arrivalItems[index],
                              );
                      },
                      title: Text(
                        direction == 'from'
                            ? departureItems[index].name
                            : nyscOption == 'general'
                                ? arrivalItems[index].name
                                : arrivalItems[index].name,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: direction == 'from'
                              ? selectedFrom == departureItems[index].name
                                  ? FontWeight.w600
                                  : FontWeight.w500
                              : nyscOption == 'general'
                              ?selectedTo == arrivalItems[index].name
                                  ? FontWeight.w600
                                  : FontWeight.w500: selectedTo == arrivalItems[index].name?FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      trailing: direction == 'from'
                          ? selectedFrom == departureItems[index].name
                              ? Icon(Icons.check,
                                  size: 15,
                                  color: Theme.of(context).primaryColor)
                              : Text('')
                          : nyscOption == 'general'
                          ?selectedTo == arrivalItems[index].name
                              ? Icon(Icons.check,
                                  size: 15,
                                  color: Theme.of(context).primaryColor)
                              : Text(''):selectedTo == arrivalItems[index].name
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

  void selectFromOption(dynamic option) {
    setState(() {
      selectedFrom = option.name;
      depatureController.text = selectedFrom;
      departureId = option.id;
    });
    print('departure');
    print(selectedFrom + '  ' + '$departureId');
    booking.getDestinationTerminals(departureId);
    Get.back();
    // var arrivals= (booking.destinationTerminalModel == null)
    //        ? []
    //        : booking.destinationTerminalModel.object
    //            .toList();
    //  print('arrivals');
    //  print(arrivals);
    // if (arrivals != null) {
    //   arrivalOptions = booking.arrivalOptions;
    //   arrivalOptionsnysc = arrivalOptions
    //       .where(
    //           (i) => i.toString().toLowerCase().contains("nysc") || i == null)
    //       .toList();
    //   generalArrivalOptions = arrivalOptions == []
    //       ? []
    //       : arrivalOptions
    //           .where((i) =>
    //               !i.toString().toLowerCase().contains("nysc") || i == null)
    //           .toList();
    //   allArrivalIds = booking.allArrivalIds;
    //   print('arrivalOptions');
    //   print(arrivalOptions);
    // }
    // print('departureId ' + departureId.toString());
    // print('departureTerminal ' + selectedFrom.toString());
  }

  void selectToOption(dynamic option) {
    setState(() {
      selectedTo = option.name;
      arrivalController.text = selectedTo;
      arrivalId = option.id;
    });

    Get.back();
    print('destination');
    print(selectedTo + '  ' + '$arrivalId');
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    booking.getAllRoute();
  }
}
