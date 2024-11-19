import 'package:flutter/material.dart';
import 'package:my_new_flutter_project/service/movie.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;

  MovieWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          // Update the image provider to AssetImage
          Image(
            image: AssetImage("assets/images/fikirSiferd.jpeg"),
            fit: BoxFit.cover,
          ),
          Text(movie.title),
        ],
      ),
    );
  }
}
