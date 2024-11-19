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
    return CinemaList(names: ['Alem Cinema', 'Sebastopol Cinema', 'Ethiopia Cinema']);
   }
  }
