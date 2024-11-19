import 'package:flutter/material.dart';

class FestivalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Public Festival'),
      children: [
        ListTile(title: Text('Coming Soon')),
      ],
    );
  }
}
