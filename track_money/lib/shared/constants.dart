import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Colors.grey,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple, width: 2)));

formInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.purple),
      hintText: 'Enter a $label',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.grey, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.purple, width: 2)));
}

moneyInputDecoration(String value) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(color: Colors.grey, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.purple, width: 2)),
    labelText: value,
    labelStyle: TextStyle(color: Colors.purple),
    hintText: 'Enter a $value',
    errorStyle: TextStyle(
      color: Colors.red,
    ),
  );
}

outlineButtonStyle(Color color) {
  return OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      primary: color,
      textStyle: TextStyle(fontSize: 24),
      side: BorderSide(color: Colors.purple, width: 3),
      minimumSize: Size(100, 50));
}
