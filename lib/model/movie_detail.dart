class MovieDetail {
  final String title;
  final String posterUrl;
  final List<CinemaShowtime> showtimes;

  MovieDetail({
    required this.title,
    required this.posterUrl,
    required this.showtimes,
  });
}

class CinemaShowtime {
  final String cinema;
  final List<String> times;

  CinemaShowtime({required this.cinema, required this.times});
}
