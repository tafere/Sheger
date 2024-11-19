import 'package:flutter/material.dart';

class Accordion extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Map<String, bool> expandedMap;

  Accordion({required this.title, required this.children, required this.expandedMap});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      initiallyExpanded: expandedMap[title] ?? false,
      onExpansionChanged: (bool expanded) {
        expandedMap[title] = expanded;
      },
      children: children,
    );
  }
}
