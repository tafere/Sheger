import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import to format dates

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SportScreen(),
  ));
}

class SportScreen extends StatefulWidget {
  @override
  _SportScreenState createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  List<Map<String, dynamic>> eplFixtures = [];
  List<Map<String, dynamic>> laLigaFixtures = [];
  bool isLoading = true;
  int currentIndex = 1; // Default to International Football (1)

  @override
  void initState() {
    super.initState();
    fetchEPLFixtures(); // Initially fetch EPL fixtures
    fetchLaLigaFixtures(); // Initially fetch La Liga fixtures
  }

  Future<void> fetchEPLFixtures() async {
    const apiUrl = 'https://api.football-data.org/v4/competitions/PL/matches';
    const apiKey = '496f9c02ede9445aa3094ac9c080c067'; // Replace with your API key.

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Auth-Token': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = data['matches'] as List?;

        if (matches == null) throw Exception('Matches data is null');

        final filteredMatches = matches.where((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateAddisAbaba = matchDateUtc.add(Duration(hours: 3)); // Addis Ababa time (UTC+3)

          return matchDateAddisAbaba.year == 2024 &&
              matchDateAddisAbaba.month == 11 &&
              matchDateAddisAbaba.day == 23;
        }).map((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateAddisAbaba = matchDateUtc.add(Duration(hours: 3)); // Addis Ababa time (UTC+3)

          final homeTeam = match['homeTeam']?['name'] ?? 'Unknown';
          final awayTeam = match['awayTeam']?['name'] ?? 'Unknown';
          final venue = match['venue'] ?? 'Unknown';
          final score = match['score']?['fullTime'] ?? {'home': null, 'away': null};
          final liveScore = match['score']?['current'] ?? {'homeTeam': null, 'awayTeam': null};
          final status = match['status'] ?? 'SCHEDULED';

          return {
            'homeTeam': homeTeam,
            'awayTeam': awayTeam,
            'date': matchDateAddisAbaba,
            'venue': venue,
            'status': status,
            'score': score,
            'liveScore': liveScore,
          };
        }).toList();

        setState(() {
          eplFixtures = filteredMatches;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load EPL fixtures');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching EPL fixtures: $e');
    }
  }

  Future<void> fetchLaLigaFixtures() async {
    const apiUrl = 'https://api.football-data.org/v4/competitions/PD/matches';
    const apiKey = '496f9c02ede9445aa3094ac9c080c067'; // Replace with your API key.

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Auth-Token': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = data['matches'] as List;

        final filteredMatches = matches.where((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateAddisAbaba = matchDateUtc.add(Duration(hours: 3)); // Addis Ababa time (UTC+3)

          return matchDateAddisAbaba.year == 2024 &&
              matchDateAddisAbaba.month == 11 &&
              matchDateAddisAbaba.day == 23;
        }).map((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateAddisAbaba = matchDateUtc.add(Duration(hours: 3)); // Addis Ababa time (UTC+3)

          return {
            'homeTeam': match['homeTeam']['name'],
            'awayTeam': match['awayTeam']['name'],
            'date': matchDateAddisAbaba,
            'venue': match['venue'] ?? 'Unknown',
          };
        }).toList();

        setState(() {
          laLigaFixtures = filteredMatches;
        });
      } else {
        throw Exception('Failed to load La Liga fixtures');
      }
    } catch (e) {
      print('Error fetching La Liga fixtures: $e');
    }
  }

  List<Widget> _buildFixtureList(List<Map<String, dynamic>> fixtures) {
    if (isLoading) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (fixtures.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(child: Text('No matches found for November 23.')),
        ),
      ];
    }

    Map<String, List<Map<String, dynamic>>> groupedFixtures = {};
    for (var match in fixtures) {
      final formattedDate = DateFormat('EEEE MM/dd/yyyy').format(match['date']);
      if (!groupedFixtures.containsKey(formattedDate)) {
        groupedFixtures[formattedDate] = [];
      }
      groupedFixtures[formattedDate]!.add(match);
    }

    List<Widget> fixtureWidgets = [];
    groupedFixtures.forEach((date, matches) {
      fixtureWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            date,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );

      matches.forEach((match) {
        final formattedTime = DateFormat('HH:mm').format(match['date']);

        // Safely retrieve the scores, using '-' if null
        final finalHomeScore = match['score']?['home'] != null
            ? match['score']['home'].toString()
            : '-';
        final finalAwayScore = match['score']?['away'] != null
            ? match['score']['away'].toString()
            : '-';

        // Check if the match is live or finished
        final bool isLiveOrFinished = match['status'] == 'LIVE' || match['status'] == 'FINISHED';

        // Display the score directly
        final String scoreDisplay = isLiveOrFinished ? '$finalHomeScore - $finalAwayScore' : 'Vs';

// Remove "FC" from team names
        String homeTeam = match['homeTeam']?.replaceAll(' FC', '') ?? 'Home';
        String awayTeam = match['awayTeam']?.replaceAll(' FC', '') ?? 'Away';

        fixtureWidgets.add(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Time
                    Text(
                      formattedTime,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    // Teams and Score
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          '$homeTeam $scoreDisplay $awayTeam',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      });

    });

    return fixtureWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ? _buildEthiopianPremierLeague() : _buildInternationalFootball(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Ethiopian Premier League',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'International Football',
          ),
        ],
      ),
    );
  }

  Widget _buildEthiopianPremierLeague() {
    return ListView.builder(
      itemCount: 1, // Example count
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Fixture: Hawassa Kenema vs Arbaminch'),
          subtitle: Text('Time: 11:00 AM | Venue: Hawassa Stadium'),
        );
      },
    );
  }

  Widget _buildInternationalFootball() {
    final List<String> leagues = [
      'English Premier League',
      'Spanish La Liga',
    ];

    return ListView.builder(
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        final league = leagues[index];

        return ExpansionTile(
          title: Text(
            league,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          children: league == 'English Premier League'
              ? _buildFixtureList(eplFixtures)
              : league == 'Spanish La Liga'
              ? _buildFixtureList(laLigaFixtures)
              : [],
        );
      },
    );
  }
}

