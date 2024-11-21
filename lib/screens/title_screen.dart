import 'package:flutter/material.dart';
import '../movies/amharic_movies.dart';
import '../movies/english_movies.dart';
import '../widgets/accordion.dart'; // Import Accordion widget

class TitleScreen extends StatelessWidget {
  final Map<String, bool> expandedMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: ListView(
        children: [
          Accordion(
            title: 'Amharic Movies',
            expandedMap: expandedMap,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0), // Indentation for child
                child: ListTile(
                  title: Text('Fikir Siferd', style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AmharicMovies()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0), // Indentation for child
                child: ListTile(
                  title: Text('Wetatua', style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AmharicMovies()),
                    );
                  },
                ),
              ),
            ],
          ),
          Accordion(
            title: 'English Movies',
            expandedMap: expandedMap,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32.0), // Indentation for child
                child: ListTile(
                  title: Text('Gladiator', style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnglishMovies()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0), // Indentation for child
                child: ListTile(
                  title: Text('Wedding Crashers', style: TextStyle(color: Colors.blue)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnglishMovies()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
