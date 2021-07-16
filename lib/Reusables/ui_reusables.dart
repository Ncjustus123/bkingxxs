import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ReusableCard extends StatelessWidget {
  final Color colour;
  final String name;
  final Function onPressed;
  final Widget cardChild;

  ReusableCard({this.colour, this.cardChild, this.onPressed, this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: cardChild,
        height: 165,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
    );
  }
}
class DropdownWidget extends StatelessWidget {
  const DropdownWidget(
      {Key key, @required this.booking, this.items, this.onchange})
      : super(key: key);

  final BookingRepository booking;
  final List<String> items;
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: items,
      onChanged: onchange,
      showSearchBox: true,
    );
  }
}
