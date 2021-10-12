import 'dart:math';
import 'dart:ui';

import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//COLORS
const Color kWhite = Color(0xFFFFFFFF);
const Color kGrey1 = Color(0xFFF4F5F7);
const Color kBlue = Color(0xFF306EFF);
const Color kGreen = Color(0xFF4CAF50);
const Color kYellow = Color(0xFFFFEB3B);
const Color kGrey = Color(0xFF9E9E9E);
const Color kRed = Color(0xFFF44336);

//TextStyle


const textStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
 TextStyle confirmationTextStyle = TextStyle(fontSize: 12, color: MyThemes.darkTheme != null?Color(0xFF85000D) : Colors.black54);
const textStyleHeading =
    TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
const textStyle1 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
const textStyle2 = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
  fontFamily: 'Monserrat',
);

String getNairaSign() {
  return "₦";
}
 String formatMoney(double amount, [int decimals = 0]) {
print(amount);
if (amount == null) {
return "₦0";
}
if (amount < 1) {
return "₦0";
}
return NumberFormat.currency(name: getNairaSign(), decimalDigits: decimals)
    .format(amount);
}

 Color getRandomColor(index) {
Random r = Random(index + 14);
Random g = Random(index + 13);
Random b = Random(index + 12);
return Color.fromARGB(255, r.nextInt(255), g.nextInt(255), b.nextInt(255));
}
 Container getCardBackground(width, height, Color c) {
return Container(
child: ClipRRect(
borderRadius: BorderRadius.all(Radius.circular(10)),
child: ColorFiltered(
colorFilter: ColorFilter.mode(c, BlendMode.hue),
child: Image.asset(
"assets/images/background.png",
//          "https://placeimg.com/680/400/nature",
fit: BoxFit.fill,
width: width,
height: height,
),
),
),
);
}






class TextFormFieldWidget extends StatelessWidget {
  final String labelText;
  final Function validator;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const TextFormFieldWidget({
    this.controller,
    this.labelText,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.textCapitalization,
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
          textCapitalization: textCapitalization ?? TextCapitalization.none,
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
            labelText: labelText,
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
