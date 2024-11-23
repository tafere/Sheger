import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import to format dates

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

  // Fetch English Premier League Fixtures
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
        final matches = data['matches'] as List;

        // Filter matches for November 23, 2024, based on Ethiopian time (UTC+3)
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

  // Fetch La Liga Fixtures
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

        // Filter matches for November 23, 2024, based on Ethiopian time (UTC+3)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ? _buildEthiopianPremierLeague() : _buildInternationalFootball(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // Set the current index based on selection
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (currentIndex == 1) {
              fetchEPLFixtures(); // Fetch EPL fixtures if selected
            } else {
              fetchLaLigaFixtures(); // Fetch La Liga fixtures if selected
            }
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

  // Build the Ethiopian Premier League Fixtures (Example mockup)
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

  // Build the football leagues' interface for International Football
  Widget _buildInternationalFootball() {
    final List<String> leagues = [
      'English Premier League',
      'Spanish La Liga',
      'Italian Serie A',
      'French Ligue 1',
      'Champions League',
    ];

    return ListView.builder(
      itemCount: leagues.length,
      itemBuilder: (context, index) {
        final String league = leagues[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ExpansionTile(
            title: Text(
              league,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            children: league == 'English Premier League'
                ? _buildFixtureList(eplFixtures)
                : league == 'Spanish La Liga'
                ? _buildFixtureList(laLigaFixtures)
                : [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Text(
                  'Upcoming Matches for $league',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Build the fixture list for each league
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

    // Group fixtures by date
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
            date, // e.g., Saturday 11/23/2024
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      );

      // Add matches for this date
      matches.forEach((match) {
        final formattedTime = DateFormat('HH:mm').format(match['date']);
        fixtureWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${match['homeTeam']} vs ${match['awayTeam']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  '$formattedTime - ${match['venue']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Divider(),
              ],
            ),
          ),
        );
      });
    });

    return fixtureWidgets;
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SportScreen(),
  ));
}

