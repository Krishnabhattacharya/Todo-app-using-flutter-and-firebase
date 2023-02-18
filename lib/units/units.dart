import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class unit {
  void toastmessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: Color.fromARGB(255, 184, 179, 22),
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
