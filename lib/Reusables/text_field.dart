import 'package:Libmot_Mobile/controllers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class InputFormField extends StatelessWidget {
   InputFormField({
    this.suffixIcon,
    this.prefixIcon,
    this.onSaved,
    this.validator,
    this.obscure,
    this.onChanged,
    this.enabled,
    this.controller,
    this.label,
    this.textCapitalization,
    this.keyboardType,
    this.inputFormatters,
    this.ontap,
    this.hintText,
    this.maxlenght,
  });

  final Widget suffixIcon;
  final int maxlenght;
  final dynamic ontap;
  final Widget prefixIcon;
  final Function onSaved;
  final Function onChanged;
  final Function validator;
  final bool enabled;
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final String hintText;
  final inputFormatters;
  ThemeProvider  themeProvider;

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      child: TextFormField(
        maxLength: maxlenght,
        onTap: ontap,
        inputFormatters: inputFormatters,
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          
          fontSize: 14,
        ),
        textCapitalization: textCapitalization??TextCapitalization.none,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscure??false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Get.isDarkMode?Color(0xFF020504) : Color(0xFFFFFFFF),
          border: InputBorder.none,
          enabledBorder: buildOutlineBorder(context),
          disabledBorder: buildOutlineBorder(context),
          focusedBorder: buildOutlineBorderless(context),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: buildOutlineBorderless(context),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: label,
          hintText: hintText,
          labelStyle: TextStyle(fontSize: 13, color: Colors.grey),
          contentPadding:
          EdgeInsets.symmetric(vertical: 18.0, horizontal: 25.0),
        ),
      ),
    );
  }
}

OutlineInputBorder buildOutlineBorderless(BuildContext context) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0.4),
      borderRadius: BorderRadius.all(Radius.circular(5)));
}

OutlineInputBorder buildOutlineBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  );
}