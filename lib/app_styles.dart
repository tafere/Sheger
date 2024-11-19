import 'package:flutter/material.dart';

class AppStyles {
  // Button Style
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 5,
    backgroundColor: Colors.orange, // Base button color
    foregroundColor: Colors.white, // Text color
  );

  // ExpansionTile title style
  static final TextStyle expansionTileTitleStyle = TextStyle(
    fontSize: 18,
    color: Colors.blue, // Color for the titles in ExpansionTile
  );

  // ListTile style
  static final ListTileThemeData listTileStyle = ListTileThemeData(
    contentPadding: EdgeInsets.only(left: 30), // Add some left padding for indentation
    tileColor: Colors.blue.shade50, // Set background color of ListTile
    textColor: Colors.black, // Set text color for ListTile
  );
}
