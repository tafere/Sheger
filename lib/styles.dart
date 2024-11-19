import 'package:flutter/material.dart';

class AppStyles {
  // Button style
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 5,
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  );
}
