import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/constants.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/Reusables/ui_reusables.dart';
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

class _BookASeatPageState extends State<BookASeatPage> {
  // with AfterLayoutMixin<BookASeatPage> {
  final dateController = TextEditingController();

  final adultController = TextEditingController();
  final childrenController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController departureController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BookingRepository booking;

  // @override
  // void afterFirstLayout(BuildContext context) {
  //   booking.getAllRoute();
  // }

  @override
  Widget build(BuildContext context) {
    // booking = Provider.of<BookingRepository>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    //TODO: show loading screen
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
                      'One way trip booking',
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
                        // booking.getBuses.tripType = index;
                        booking.tripTypeChange(index);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35)),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    children: [
                      tripOptionButton(context: context, title: 'One Way'),
                      tripOptionButton(context: context, title: 'Round Trip'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),

              // DropdownWidget(
              //   booking: booking,
              //   items: (booking.getRouteModel == null)
              //       ? []
              //       : booking.getRouteModel.object.items
              //           .map((RouteItems route) => route.name)
              //           .toList(),
              //   onchange: (String name) {
              //     RouteItems route = booking.getRouteModel.object.items
              //         .singleWhere((element) => element.name == name);
              //
              //     booking.getBuses.departureTerminalId = route.id;
              //     booking.getDestinationTerminals(
              //         booking.getBuses.departureTerminalId);
              //   },
              // ),
              // DropdownWidget(
              //   booking: booking,
              //   items: (booking.destinationTerminalModel == null)
              //       ? []
              //       : booking.destinationTerminalModel.object
              //           .map((DestinationObject object) => object.name)
              //           .toList(),
              //   onchange: (String name) {
              //     DestinationObject object = booking
              //         .destinationTerminalModel.object
              //         .singleWhere((element) => element.name == name);
              //     booking.getBuses.destinationTerminalId = object.id;
              //   },
              // ),
              // depatureDateField(context),
              // (booking.getBuses.tripType == 1)
              //     ? arrivalDateField(context)
              //     : SizedBox(),
              // fromField(adultController),
              // fromField(childrenController),
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
                          InputFormField(
                            suffixIcon: Icon(Icons.place),
                            label: 'From',
                          ),
                          InputFormField(
                            suffixIcon: Icon(Icons.place),
                            label: 'To',
                          ),
                          InkWell(
                            onTap: () async {
                              DateTime chosenDate = await showDatePicker(
                                helpText: 'Departure Date',
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                lastDate: DateTime(DateTime.now().year + 2),
                              );
                              if (chosenDate != null) {
                                setState(() {
                                  departureController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(chosenDate)
                                          .toString();
                                });
                              }
                            },
                            child: InputFormField(
                              enabled: false,
                              controller: departureController,
                              suffixIcon: Icon(Icons.event_note),
                              label: 'Departure Date',
                            ),
                          ),

                          InkWell(
                            onTap: () async {
                              DateTime chosenDate = await showDatePicker(
                                context: context,
                                helpText: 'Arrival Date',
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day),
                                lastDate: DateTime(DateTime.now().year + 2),
                              );
                              if (chosenDate != null) {
                                setState(() {
                                  arrivalController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(chosenDate)
                                          .toString();
                                });
                              }
                            },
                            child: InputFormField(
                              enabled: false,
                              controller: arrivalController,
                              suffixIcon: Icon(Icons.event_note),
                              label: 'Arrival Date',
                            ),
                          ),
                          Buttons.coloredButton(
                            context: context,
                            title: 'Book',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => SingleChildScrollView(
                                  child: bottomSheet(context, _height, _width),
                                ),
                              );
                            },
                          ),

                          // Center(
                          //     child: Text(
                          //   "Travellers",
                          //   style: textStyle1,
                          // )),
                          // SizedBox(height: 30),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Text(
                          //       "Adult",
                          //       style: textStyle2,
                          //     ),
                          //     Text(
                          //       "Child(ren)",
                          //       style: textStyle2,
                          //     ),
                          //   ],
                          // ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     Expanded(child: adulttravellersButton()),
                          //     Expanded(child: booking.childrentravellersButton()),
                          //   ],
                          // ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // proceedButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Container bottomSheet(BuildContext context, double _height, double _width) {
    return Container(
      color: Colors.transparent,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: _height * 0.4,
        width: _width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Text(
                  'Travellers',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  'Select the number of persons travelling',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    travellerOption(context, 'Adult(s)'),
                    SizedBox(width: 15),
                    travellerOption(context, 'Children(ren)'),
                  ],
                ),
                Buttons.coloredButton(
                  context: context,
                  title: 'Proceed',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded travellerOption(BuildContext context, title) {
    return Expanded(
        child: Column(
      children: [
        Center(
            child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addButton(context: context, icon: Icons.add, onTap: () {}),
            Expanded(
                child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            )),
            addButton(context: context, icon: Icons.remove, onTap: () {}),
          ],
        ),
      ],
    ));
  }

  addButton({BuildContext context, icon, onTap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 1.5,
        shape: CircleBorder(),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(0.5, 0.9),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 20,
              )),
            ),
          ),
        ),
      ),
    );
  }

  String tripOption = 'One Way';

  Expanded tripOptionButton({BuildContext context, title}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        setState(() {
          tripOption = title;
        });
      },
      child: Container(
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.white, offset: Offset(2, 4))
              ],
              color: tripOption == title
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(35)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: tripOption == title
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )),
          )),
    ));
  }
//
// SizedBox proceedButton(BuildContext context) {
//   return SizedBox(
//     width: 200.0,
//     height: 50.0,
//     child: ElevatedButton(
//       onPressed: () {
//         //booking.getBuses.numberOfAdults = int.parse(adultController.text);
//         //       //booking.getBuses.numberOfChildren = int.parse(childrenController.text);
//         //       //TODO;;;; authentication
//
//         //       //booking.getBuses.departureDate = dateController.text.toString();
//         booking.searchBuses(_scaffoldKey, context);
//       },
//       child: Text("Proceed"),
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(Colors.red),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// fromField(controller) {
//   return TextFormField(
//     controller: controller,
//     validator: (value) {
//       if (value.isEmpty) {
//         return 'Please input a departure address';
//       }
//       return null;
//     },
//   );
// }
//
// depatureDateField(context) {
//   return TextFormField(
//     readOnly: true,
//     controller: dateController,
//     validator: (value) {
//       if (value.isEmpty) {
//         return 'Please select departure date';
//       }
//       return null;
//     },
//     onTap: () async {
//       DateTime selectedTime = await booking.showDate(context);
//
//       dateController.text = '${DateFormat('yMMMd').format(selectedTime)}';
//       booking.getBuses.departureDate =
//           "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
//     },
//   );
// }
//
// arrivalDateField(context) {
//   return TextFormField(
//     readOnly: true,
//     controller: dateController,
//     validator: (value) {
//       if (value.isEmpty) {
//         return 'Please select departure date';
//       }
//       return null;
//     },
//     onTap: () async {
//       DateTime selectedTime = await booking.showDate(context);
//
//       dateController.text = '${DateFormat('yMMMd').format(selectedTime)}';
//       booking.getBuses.departureDate =
//           "${DateFormat('yyyy-MM-dd').format(selectedTime)}";
//     },
//   );
// }
//
// Container adulttravellersButton() {
//   return Container(
//     height: 50,
//     width: 50,
//     child: new Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         new FloatingActionButton(
//           heroTag: null,
//           onPressed: booking.addAdult,
//           child: new Icon(
//             Icons.add,
//             color: Colors.black,
//           ),
//           backgroundColor: Colors.red,
//         ),
//         new Text('${booking.getBuses.numberOfAdults}',
//             style: new TextStyle(fontSize: 30.0)),
//         new FloatingActionButton(
//           heroTag: null,
//           onPressed: booking.subtractAdult,
//           child: new Icon(
//             Icons.horizontal_rule,
//             color: Colors.black,
//           ),
//           backgroundColor: Colors.red,
//         ),
//       ],
//     ),
//   );
// }

}
