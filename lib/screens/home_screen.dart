import 'package:flutter/material.dart';
import 'package:my_new_flutter_project/model/movie_detail.dart'; // Correct MovieDetail import
import 'package:my_new_flutter_project/screens/movie_detail_page.dart'; // Correct MovieDetailPage import
import 'movie_screen.dart'; // Import MovieScreen from the screens directory
import 'festival_screen.dart';
import 'sport_screen.dart';
import 'cinema_screen.dart';
import 'title_screen.dart';
import '../service/movie_service.dart';

class HomeScreen extends StatelessWidget {
  // Removed the MovieService import since it's not being used anymore for MovieDetailPage navigation
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sheger Events',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0, // No shadow for the app bar for a clean look
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ExpansionTile(
              title: Text(
                  'Movies',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              children: [
                ExpansionTile(
                  title: Text(
                      'Cinema',
                    style: TextStyle(fontSize: 18),
                  ),
                  children: movieService.fetchCinemaNames().names.map((name) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: ListTile(
                        title: Text(name),
                      ),
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  title: Text('Title'),
                  children: [
                    ExpansionTile(
                      title: Text('Amharic Movies'),
                      children: movieService.fetchMovies('Amharic Movies').map((movie) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 48.0),
                          child: ListTile(
                            title: Text(movie.title),
                            onTap: () {
                              // Navigate to MovieDetailPage with the selected movie details
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailPage(
                                    movieDetail: MovieDetail(
                                      title: movie.title,
                                      posterUrl: movie.posterUrl,
                                      showtimes: movie.showtimes,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    ExpansionTile(
                      title: Text('English Movies'),
                      children: movieService.fetchMovies('English Movies').map((movie) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 48.0),
                          child: ListTile(title: Text(movie.title)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                  'Sport',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: ListTile(title: Text('Coming Soon')),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                  'Public Festival',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: ListTile(title: Text('Coming Soon')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
