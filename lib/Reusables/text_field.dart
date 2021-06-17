import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
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
  });

  final Widget suffixIcon;
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
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12),
      child: TextFormField(
        inputFormatters: inputFormatters,
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 13,
        ),
        textCapitalization: textCapitalization??TextCapitalization.none,
        validator: validator,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscure??false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFFFFFFF),
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