import 'package:flutter/material.dart';

InputDecoration AppInputDecoration(label) {
  return InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      labelText: label);
}

ButtonStyle AppInputButtonStyle() {
  return ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
    vertical: 20,
  ),
  foregroundColor: Colors.white,
  backgroundColor: Colors.indigo);

}
