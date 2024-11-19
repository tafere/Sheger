class DataService {
  // Simulated database of movies
  final Map<String, List<String>> _moviesDatabase = {
    'Amharic': ['Fikir Siferddd', 'Wetatua', 'Tafere'],
    'English': ['Gladiator', 'Wedding Crashers'],
    // Add more languages or categories as needed
  };

  Future<List<String>> fetchMoviesByLanguage(String language) async {
    // Simulate a database or API call with a delay
    await Future.delayed(Duration(seconds: 2));

    // Return movies for the specified language
    if (!_moviesDatabase.containsKey(language)) {
      print("XXXXXXXXXXXXXXXX");
      print("No Language Found");
      print("XXXXXXXXXXXXXXXX");
      return _moviesDatabase[language]!;
    }
    if (_moviesDatabase.containsKey(language)) {
      print("XXXXXXXXXXXXXXXX");
      print(language);
      print("XXXXXXXXXXXXXXXX");
      return _moviesDatabase[language]!;
    } else {
      print("XXXXXXXXXXXXXXXX");
      print("Tafere");
      print("XXXXXXXXXXXXXXXX");
      throw Exception('Movies not found for language: $language');
    }
  }
}

