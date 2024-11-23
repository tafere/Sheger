import '../model/movie_detail.dart';
class DataService {
  Future<List<MovieDetail>> fetchMoviesByCategory(String category) async {
    // Simulate dynamic data fetching
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    if (category == 'Amharic Movies') {
      return [
        MovieDetail(
          title: 'Fikir Siferd',
          posterUrl: 'assets/images/fikirSiferd.jpeg',
          showtimes: [
            CinemaShowtime(cinema: 'Alem Cinema', times: ['1:00pm', '4:30pm', '7:00pm']),
            CinemaShowtime(cinema: 'Sebastopol', times: ['2:00pm', '7:00pm']),
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
    } else if (category == 'English Movies') {
      return [
        MovieDetail(
          title: 'The Marvels',
          posterUrl: 'assets/images/marvels.jpeg',
          showtimes: [
            CinemaShowtime(cinema: 'Alem Cinema', times: ['1:00pm', '5:00pm']),
          ],
        ),
      ];
    }
    return [];
  }
}
