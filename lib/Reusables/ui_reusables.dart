import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dropdown_search/dropdown_search.dart';

class UIReusable{
  static void showLoading( {@required Color progressColor, Color backgroundColor, Color indicatorColor,Color textColor,  
 EasyLoadingIndicatorType indicatorType, status}){
  EasyLoading.instance
  ..displayDuration =  const Duration(milliseconds: 1000)
  ..indicatorType = indicatorType
  ..loadingStyle = EasyLoadingStyle.custom
  ..indicatorSize = 45.0
  ..radius = 10.0
  ..progressColor = progressColor
  ..backgroundColor = backgroundColor
  ..indicatorColor = indicatorColor
  ..textColor = textColor
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = false
  ..dismissOnTap = false
  ;
  EasyLoading.show(status: status); 
}
}

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
        height: 120,
        width: 120,
        margin: EdgeInsets.all(15.0),
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
  final List <String>  items;
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