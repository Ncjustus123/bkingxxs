import 'dart:ui';

import 'package:flutter/material.dart';

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
const textStyle1 =
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
const textStyle2 =
    TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

String getNairaSign() {
  return "₦";
}

class ButtonReusable extends StatelessWidget {
  final Function onpressed;
  final String name;

  const ButtonReusable({this.onpressed, this.name});

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
              MaterialStateProperty.all(Theme.of(context).primaryColor),
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

  const TextFormFeildWidget({
    this.controller,
    this.lableText,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
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
