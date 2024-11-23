import 'package:my_new_flutter_project/model/movie_detail.dart';
import '../model/cinema_list.dart';

class MovieService {
  List<MovieDetail> fetchMovies(String category) {
    print('Fetching movies for category: $category');

    if (category == 'Amharic Movies') {
      return [
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
    }
    // Add more categories logic as needed
    return [];
  }

  CinemaList fetchCinemaNames() {
    return CinemaList(cinemas: [
      Cinema(
        name: 'Alem Cinema',
        address: 'ABCS Dr, Addis Ababa',
        logoUrl: 'assets/images/alem_cinema_logo.png',  // Replace with actual path to the logo
        latitude: 9.0304,  // Add latitude for Alem Cinema
        longitude: 38.7428,  // Add longitude for Alem Cinema
      ),
      Cinema(
        name: 'Sebastopol Cinema',
        address: '1234 Abc Ln, Sebastopol',
        logoUrl: 'assets/images/sebastopol_logo.png',  // Replace with actual path to the logo
        latitude: 38.4065,  // Add latitude for Sebastopol Cinema
        longitude: -122.9330,  // Add longitude for Sebastopol Cinema
      ),
      Cinema(
        name: 'Ethiopia Cinema',
        address: '1234 Main Road, Addis Ababa',
        logoUrl: 'assets/images/ethiopia_cinema_logo.png',  // Replace with actual path to the logo
        latitude: 9.0347,  // Add latitude for Ethiopia Cinema
        longitude: 38.7460,  // Add longitude for Ethiopia Cinema
      ),
    ]);
  }
}
