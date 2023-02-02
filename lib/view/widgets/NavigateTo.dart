import 'package:flutter/material.dart';

To(
  context, {
  required Widget route,
}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return route;
    }));

ToAndRemove(
  context, {
  required Widget route,
}) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return route;
    }), (route) => false);
