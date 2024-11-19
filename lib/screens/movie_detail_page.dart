import 'package:flutter/material.dart';
import '../model/movie_detail.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieDetail movieDetail;

  MovieDetailPage({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieDetail.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie poster (local image)
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(movieDetail.posterUrl), // Use local image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Showtimes section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Showtimes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movieDetail.showtimes.length,
              itemBuilder: (context, index) {
                final showtime = movieDetail.showtimes[index];
                return ListTile(
                  title: Text(showtime.cinema),
                  subtitle: Text(showtime.times.join('   ')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
