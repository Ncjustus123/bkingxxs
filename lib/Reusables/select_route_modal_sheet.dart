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
      color: Colors.transparent,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: _height * 0.5,
        width: _width,
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
                'Depatures',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              SizedBox(height: 15),
              Column(
                  children: List<Widget>.generate(
                    options.length,
                    (index) {
                      return ListTile(
                          onTap: () {
                            selectOption(index);
                          },
                          leading: selected == options[index]
                              ? Icon(Icons.check_rounded)
                              : Container(),
                          title: Text(options[index]));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> options = [
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
    'bayeyey',
  ];
  String selected = '';
  selectOption(option) {
    Get.back();
    setState(() {
      selected = option;
    });
  }
}
