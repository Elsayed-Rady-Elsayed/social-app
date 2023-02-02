import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Toast({
  required String msg
}){
  Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
}