import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Categories',
      theme: ThemeData(
        primaryColor: Color(0xff00695c), // Primary color for AppBar and main elements
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xff00695c), // Main primary color
          secondary: Colors.cyan, // Secondary/accent color
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff00695c),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
