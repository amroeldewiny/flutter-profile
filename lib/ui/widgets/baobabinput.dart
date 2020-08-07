import 'package:flutter/material.dart';

// Input Style decoration widget
// ignore: non_constant_identifier_names
InputDecoration BaobabInputDecoration(String hintText, icon) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(
      icon,
      color: Colors.grey[500],
    ),
    hintStyle: TextStyle(color: Colors.grey[500]),
    filled: true,
    fillColor: Colors.white,
    border: const OutlineInputBorder(),
    enabledBorder: new UnderlineInputBorder(
      borderSide: new BorderSide(color: Colors.white),
      //borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      //borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent[100])),
    errorStyle: TextStyle(color: Colors.redAccent[100]),
  );
}

// TextInput Style decoration widget
// ignore: non_constant_identifier_names
TextStyle BaobabFieldStyle() {
  return TextStyle(
    color: Colors.grey[500],
    fontSize: 14.0,
  );
}
