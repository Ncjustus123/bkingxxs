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
class ButtonClass extends StatelessWidget {
  final Function onpressed;
  final BorderSide side;
  final Color color;
  final Widget title;
  ButtonClass({ this.onpressed,this.title,this.color,this.side});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: title,
        onPressed: onpressed,
        style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: side,
            ),
          ),
        ),
      ),
    );
  }

}
class WidgetTextField extends StatelessWidget {
  final String lableText;
  final Function validator;
  final controller;
  // final Function onTap;
  const WidgetTextField({
    Key key,
    @required this.lableText,
    this.validator,
    @required this.controller,
    // this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextFormField(
            //onTap: onTap,
            decoration: InputDecoration(
              fillColor: Colors.grey,
              focusColor: Colors.grey,
              border: InputBorder.none,
              labelText: lableText,
              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            ),
            controller: controller,
            validator: validator,
          ),
        ),
      ),
    );
  }
}
