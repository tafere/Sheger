import 'package:flutter/material.dart';

class CinemaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Cinema'),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32.0), // Indentation for child items
          child: ListTile(title: Text('Alem')),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0), // Indentation for child items
          child: ListTile(title: Text('Sebastopol')),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0), // Indentation for child items
          child: ListTile(title: Text('Ethiopia')),
        ),
      ],
    );
  }
}
