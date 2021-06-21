import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:Libmot_Mobile/view/widgets/appBar_passenger_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BottomRouteSheet extends StatefulWidget {
  BookingRepository booking;

  //final List <String>  items;

  @override
  _BottomRouteSheetState createState() => _BottomRouteSheetState();
}

class _BottomRouteSheetState extends State<BottomRouteSheet> {
  @override
  Widget build(BuildContext context) {
    booking = Provider.of<BookingRepository>(context);
    //int index = booking.getRouteModel.object.items.length;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      height: _height * 0.4,
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
            padding: const EdgeInsets.all(15.0),
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
            'Departures',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  children: List<Widget>.generate(options.length, (index) {
                    return new ListTile(
                      onTap: () => selectOption(options[index]),
                      title: Text(
                        options[index],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: selected == options[index]
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                      leading: selected == options[index]
                          ? Icon(Icons.check,
                              size: 15, color: Theme.of(context).primaryColor)
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

  // buildDropList(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
  //         color: Theme.of(context).scaffoldBackgroundColor),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: InkWell(
  //               onTap: () {
  //                 Get.back();
  //               },
  //               child: Container(
  //                 width: 50,
  //                 height: 4,
  //                 color: Theme.of(context).primaryColor,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             'Departures',
  //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
  //           ),
  //           SizedBox(height: 15),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  //                 child: Column(
  //                   children: List<Widget>.generate(options.length, (index) {
  //                       return ListTile(
  //                           onTap: () {
  //                             selectOption(options[index]);
  //                           },
  //                           leading: selected == options[index]
  //                               ? Icon(Icons.check_rounded)
  //                               : Container(),
  //                           title: Text(options[index]));
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  List<String> options = [
    'bayeyey',
    'bayeyey1',
    'bayeyey2',
    'bayeyey4',
    'bayeyey5',
    'bayeye4y',
    'bayeyey8',
  ];
  String selected = '';

  void selectOption(String option) {
    Get.back();
    setState(() {
      selected = option;
    });
  }
}
