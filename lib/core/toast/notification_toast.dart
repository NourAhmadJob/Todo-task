import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationManager {
  void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      gravity: ToastGravity.BOTTOM,
      fontSize: 18.0,
    );
  }

  void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      gravity: ToastGravity.BOTTOM,
      fontSize: 18.0,
    );
  }
}
