import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
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
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscure ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Get.isDarkMode ? Color(0xFF55555) : Color(0xFFFFFFFF),
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

class TextFormFieldWidget extends StatelessWidget {
  final String lableText;
  final Function validator;
  final TextEditingController controller;
  final bool obscureText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  const TextFormFieldWidget({
    this.controller,
    this.lableText,
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
          style: TextStyle(fontSize: 13, color: Colors.black87),
          keyboardType: keyboardType,
          obscureText: obscureText,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Get.isDarkMode ? Color(0xFF020504) : Color(0xFFFFFFFF),
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
