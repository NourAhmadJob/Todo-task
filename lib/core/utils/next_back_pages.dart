import 'package:flutter/material.dart';
class NextBackPages {
  void nextPage(context , Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
  void backPage(context) {
    Navigator.of(context).pop();
  }
}