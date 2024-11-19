// import 'package:flutter/material.dart';
// import '../movies/amharic_movies.dart';
// import '../movies/english_movies.dart';
// import '../widgets/accordion.dart'; // Import Accordion widget
//
// class TitleScreen extends StatelessWidget {
//   final Map<String, bool> expandedMap = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Title')),
//       body: ListView(
//         children: [
//           Accordion(
//             title: 'Amharic Movies',
//             expandedMap: expandedMap,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 32.0), // Indentation for child
//                 child: ListTile(
//                   title: Text('Fikir Siferd', style: TextStyle(color: Colors.blue)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AmharicMovies()),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 32.0), // Indentation for child
//                 child: ListTile(
//                   title: Text('Wetatua', style: TextStyle(color: Colors.blue)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AmharicMovies()),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Accordion(
//             title: 'English Movies',
//             expandedMap: expandedMap,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 32.0), // Indentation for child
//                 child: ListTile(
//                   title: Text('Gladiator', style: TextStyle(color: Colors.blue)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => EnglishMovies()),
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 32.0), // Indentation for child
//                 child: ListTile(
//                   title: Text('Wedding Crashers', style: TextStyle(color: Colors.blue)),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => EnglishMovies()),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../service/data_service.dart'; // Import your data service
import '../widgets/accordion.dart'; // Import Accordion widget

class TitleScreen extends StatelessWidget {
  final Map<String, bool> expandedMap = {};

  Future<List<String>> _fetchMovies(String language) async {
    return await DataService().fetchMoviesByLanguage(language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: ListView(
        children: [
          FutureBuilder<List<String>>(
            future: _fetchMovies('Amharic'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Amharic Movies Found'));
              }
              final amharicMovies = snapshot.data!;
              return Accordion(
                title: 'Amharic Movies',
                expandedMap: expandedMap,
                children: amharicMovies
                    .map(
                      (movie) => Padding(
                    padding: const EdgeInsets.only(left: 32.0), // Indentation for child
                    child: ListTile(
                      title: Text(movie, style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                )
                    .toList(),
              );
            },
          ),
          FutureBuilder<List<String>>(
            future: _fetchMovies('English'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No English Movies Found'));
              }
              final englishMovies = snapshot.data!;
              return Accordion(
                title: 'English Movies',
                expandedMap: expandedMap,
                children: englishMovies
                    .map(
                      (movie) => Padding(
                    padding: const EdgeInsets.only(left: 32.0), // Indentation for child
                    child: ListTile(
                      title: Text(movie, style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
