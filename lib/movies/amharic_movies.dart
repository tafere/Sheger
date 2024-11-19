import 'package:flutter/material.dart';
import '../screens/movie_detail_page.dart'; // Import the MovieDetailPage
import '../model/movie_detail.dart'; // Import the correct CinemaShowtime model

class AmharicMovies extends StatelessWidget {
  final List<MovieDetail> movies = [
    MovieDetail(
      title: 'Fikir Siferd',
      posterUrl: 'assets/images/fikirSiferd.jpeg',
      showtimes: [
        CinemaShowtime(cinema: 'Alem Cinema', times: ['1:00pm', '4:30pm', '7:00pm']),
        CinemaShowtime(cinema: 'Sebastopol', times: ['2:00pm', '7:00pm']),
        CinemaShowtime(cinema: 'Ethiopia', times: ['11:00am']),
      ],
    ),
    MovieDetail(
      title: 'Wetatua',
      posterUrl: 'assets/images/sebastopol.jpg',
      showtimes: [
        CinemaShowtime(cinema: 'Alem Cinema', times: ['12:00pm', '3:30pm']),
        CinemaShowtime(cinema: 'Sebastopol', times: ['1:30pm', '6:00pm']),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Amharic Movies')),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            leading: Image.asset(movie.posterUrl),
            title: Text(movie.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieDetail: movie),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
