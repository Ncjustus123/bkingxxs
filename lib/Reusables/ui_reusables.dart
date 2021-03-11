import 'package:Libmot_Mobile/repository/booking_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
class DropdownWidget extends StatelessWidget {
  const DropdownWidget(
      {Key key, @required this.booking, this.items, this.onchange})
      : super(key: key);

  final BookingRepository booking;
  final List<DropdownMenuItem<String>>  items;
  final Function onchange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: items,
      onChanged: onchange,
    );
  }
  
}