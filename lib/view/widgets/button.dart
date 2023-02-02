import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Button({
  required String title,
  required var press,
}) =>
    MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: press,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      height: 50,
      minWidth: double.infinity,
    );
