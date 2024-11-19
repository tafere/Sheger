import 'package:flutter/material.dart';

class SportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Sport'),
      children: [
        ListTile(title: Text('Coming Soon')),
      ],
    );
  }
}
