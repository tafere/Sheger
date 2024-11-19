import 'package:flutter/material.dart';
import 'cinema_screen.dart';
import 'title_screen.dart';

class MovieScreen extends StatelessWidget {
  final String category;

  MovieScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    if (category == 'Cinema') {
      return CinemaScreen();
    } else if (category == 'Title') {
      return TitleScreen();
    }
    return Container();
  }
}
