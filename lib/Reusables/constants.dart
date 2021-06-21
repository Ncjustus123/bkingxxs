import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//COLORS
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey1 = Color(0xFFF4F5F7);
const Color kBlue = Color(0xFF306EFF);
const Color kGreen = Color(0xFF4CAF50);
const Color kYellow = Color(0xFFFFEB3B);
const Color kGrey = Color(0xFF9E9E9E);
const Color kRed = Color(0xFFF44336);

//TextStyle

const textStyle = TextStyle(color: Colors.white, fontSize: 18);
const textStyleHeading = TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w500);
const textStyle1 =
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
const textStyle2 =
    TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500);

String getNairaSign() {
  return "₦";
}

dialog(context,String title, content) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 90,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              content,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Spacer(),
            SmallButtonReusable(
              name: "Okay",
              onpressed: (){
                
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class ButtonReusable extends StatelessWidget {
  final Function onpressed;
  final String name;
  final Color color;
  final Color textcolor;

  const ButtonReusable({this.onpressed, this.name,this.color,this.textcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: Text(
          name,
          style: TextStyle(color: textcolor),
        ),
        onPressed: onpressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class SmallButtonReusable extends StatelessWidget {
  final Function onpressed;
  final String name;

  const SmallButtonReusable({this.onpressed, this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onpressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class WhiteButtonReusable extends StatelessWidget {
  final Function onpressed;
  final String name;

  const WhiteButtonReusable({this.onpressed, this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        child: Text(name,style:TextStyle(color: Colors.white),),
        onPressed: onpressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Colors.grey),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomLeft:Radius.circular(10),bottomRight: Radius.circular(10),  ),
            ),
          ),
        ),
      ),
    );
  }
}


class TextFormFeildWidget extends StatelessWidget {
  final String lableText;
  final Function validator;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputType keyboardType;

  const TextFormFeildWidget({
    this.controller,
    this.lableText,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[200],
                blurRadius: 0.5,
                spreadRadius: 2,
                offset: Offset(0.3, 0.6))
          ]),
      margin: EdgeInsets.only(bottom: 5.0, left: 12, right: 12, top: 5),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        child: TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3), width: 0.4)),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.3), width: 0.4)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: Colors.red.withOpacity(0.6), width: 0.6)),
            labelText: lableText,
            labelStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          ),
          //key: _formKeyLogin,
          controller: controller,
          validator: validator,
        ),
      ),
    );
  }
}
