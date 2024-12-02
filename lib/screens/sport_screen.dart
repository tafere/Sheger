import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // For formatting dates

class SportScreen extends StatefulWidget {
  @override
  _SportScreenState createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> eplFixtures = [];
  List<Map<String, dynamic>> laLigaFixtures = [];
  List<Map<String, dynamic>> championsLeagueFixtures = [];
  // List<Map<String, dynamic>> europaLeagueFixtures = [];

  final Map<String, String> leagueEmblems = {
    'PL': 'https://crests.football-data.org/PL.png', // Premier League
    'PD': 'https://crests.football-data.org/PD.png', // La Liga
    'CL': 'https://crests.football-data.org/CL.png', // Champions League
    // 'EL': 'https://crests.football-data.org/EL.png', //European League
  };

  bool isLoading = false;
  bool eplExpanded = true; // Tracks if EPL section is expanded
  bool laLigaExpanded = false; // Tracks if La Liga section is expanded
  bool championsLeagueExpanded = false; // Tracks if Champions League section is expanded
  // bool europaLeagueExpanded = false; //Tracks if Europa League section is expanded
  List<DateTime> displayedDates = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    displayedDates = _generateWeekRange(selectedDate);
    fetchFixturesForDate(selectedDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  List<DateTime> _generateWeekRange(DateTime baseDate) {
    final List<DateTime> dates = [];
    final startOfWeek = baseDate.subtract(Duration(days: baseDate.weekday - 1));
    for (int i = 0; i < 7; i++) {
      dates.add(startOfWeek.add(Duration(days: i)));
    }
    return dates;
  }

  Future<void> fetchFixturesForDate(DateTime date) async {
    setState(() {
      isLoading = true;
      eplFixtures = [];
      laLigaFixtures = [];
      championsLeagueFixtures = [];
      // europaLeagueFixtures = [];
    });

    await Future.wait([
      fetchLeagueFixtures(date, 'PL', eplFixtures), // EPL
      fetchLeagueFixtures(date, 'PD', laLigaFixtures), // La Liga
      fetchLeagueFixtures(date, 'CL', championsLeagueFixtures), // Champions League
      // fetchLeagueFixtures(date, 'EL', europaLeagueFixtures), // Europa League

    ]);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchLeagueFixtures(DateTime date, String leagueCode, List<Map<String, dynamic>> targetList) async {
    const apiUrlTemplate = 'https://api.football-data.org/v4/competitions/{leagueCode}/matches';
    const apiKey = '496f9c02ede9445aa3094ac9c080c067';
    final apiUrl = apiUrlTemplate.replaceFirst('{leagueCode}', leagueCode);

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Auth-Token': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final matches = data['matches'] as List?;

        if (matches == null) throw Exception('No matches data available.');

        final filteredMatches = matches.where((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateLocal = matchDateUtc.add(Duration(hours: 3)); // Adjust timezone

          return matchDateLocal.year == date.year &&
              matchDateLocal.month == date.month &&
              matchDateLocal.day == date.day;
        }).map((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateLocal = matchDateUtc.add(Duration(hours: 3));

          return {
            'homeTeam': match['homeTeam']?['shortName'] ?? 'Unknown',
            'awayTeam': match['awayTeam']?['shortName'] ?? 'Unknown',
            'date': matchDateLocal,
            'status': match['status'] ?? 'SCHEDULED',
            'score': match['score']?['fullTime'] ?? {'home': null, 'away': null},
            'homeTeamEmblem': match['homeTeam']?['crest'] ?? '',
            'awayTeamEmblem': match['awayTeam']?['crest'] ?? '',
          };
        }).toList();

        setState(() {
          targetList.addAll(filteredMatches);
        });
      } else {
        throw Exception('Failed to load fixtures: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching fixtures for $leagueCode: $e');
    }
  }

  void _changeDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      displayedDates = _generateWeekRange(newDate);
    });
    fetchFixturesForDate(newDate);
  }

  void _scrollToSelectedDate() {
    final index = displayedDates.indexOf(selectedDate);
    if (index != -1) {
      _scrollController.animateTo(
        index * (MediaQuery.of(context).size.width / 7),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String monthName = DateFormat('MMMM').format(selectedDate);
    final double buttonSize = MediaQuery.of(context).size.width / 7;

    return Scaffold(
      body: Column(
        children: [
          // Month navigation and date selection
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                // Month navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () => _changeDate(selectedDate.subtract(Duration(days: 7))),
                    ),
                    Text(
                      monthName,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () => _changeDate(selectedDate.add(Duration(days: 7))),
                    ),
                  ],
                ),
                // Date selection
                SizedBox(
                  height: buttonSize-1/7*buttonSize,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: displayedDates.length,
                    itemBuilder: (context, index) {
                      final date = displayedDates[index];
                      final dayAbbreviation = DateFormat('E').format(date).substring(0, 1);
                      final formattedDate = DateFormat('dd').format(date);

                      return GestureDetector(
                        onTap: () => _changeDate(date),
                        child: Container(
                          width: buttonSize-1/7*buttonSize,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: selectedDate == date ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selectedDate == date ? Colors.blue : Colors.grey,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dayAbbreviation,
                                style: TextStyle(
                                  color: selectedDate == date ? Colors.white : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: selectedDate == date ? Colors.white : Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Expandable fixtures sections
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
              children: [
                // Custom style for EPL
                buildLeagueSection(
                  'English Premier League',
                  eplFixtures,
                  eplExpanded,
                      (expanded) {
                    setState(() {
                      eplExpanded = expanded;
                    });
                  },
                  'https://crests.football-data.org/PL.png', // Correct Champions League Logo URL
                  TextStyle(
                    fontSize: 16, // Increased font size
                    color: Colors.black, // Custom color for EPL
                    // fontWeight: FontWeight.bold, // Bold font
                  ),
                ),
                // Custom style for La Liga
                buildLeagueSection(
                  'Spanish La Liga',
                  laLigaFixtures,
                  laLigaExpanded,
                      (expanded) {
                    setState(() {
                      laLigaExpanded = expanded;
                    });
                  },
                  'https://crests.football-data.org/laliga.png', // Correct Champions League Logo URL
                  TextStyle(
                    fontSize: 16, // Increased font size
                    color: Colors.black, // Custom color for La Liga
                    // fontWeight: FontWeight.bold, // Bold font
                  ),
                ),
                // Custom style for champions League
                buildLeagueSection(
                  'UEFA Champions League',
                  championsLeagueFixtures,
                  championsLeagueExpanded,
                      (expanded) {
                    setState(() {
                      championsLeagueExpanded = expanded;
                    });
                  },
                  'https://crests.football-data.org/CL.png', // Correct Champions League Logo URL
                  TextStyle(
                    fontSize: 16, // Increased font size
                    color: Colors.black, // Custom color for La Liga
                    // fontWeight: FontWeight.bold, // Bold font
                  ),
                ),
                // Custom style for European League
                // buildLeagueSection(
                //   'UEFA European League',
                //   europaLeagueFixtures,
                //   europaLeagueExpanded,
                //       (expanded) {
                //     setState(() {
                //       europaLeagueExpanded = expanded;
                //     });
                //   },
                //   'https://crests.football-data.org/EL.png', // Correct European League Logo URL
                //   TextStyle(
                //     fontSize: 16, // Increased font size
                //     color: Colors.black, // Custom color for La Liga
                //     // fontWeight: FontWeight.bold, // Bold font
                //   ),
                // ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  // Correct URL for each league's emblem
  Widget buildLeagueSection(
      String title,
      List<Map<String, dynamic>> fixtures,
      bool isExpanded,
      Function(bool) onExpansionChanged,
      String logoUrl, // The logoUrl parameter should be passed from leagueEmblems
      TextStyle titleStyle,
      ) {
    final fixtureCount = fixtures.length;
    final sectionTitle = fixtureCount > 0
        ? '$title ($fixtureCount games)'
        : '$title (no games)';

    return ExpansionTile(
      title: Row(
        children: [
          // Display league emblem
          Image.network(
            logoUrl, // This is where the league emblem URL is used
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.sports_soccer, size: 20); // Placeholder in case the image fails
            },
          ),
          SizedBox(width: 4),
          Text(
            sectionTitle,
            style: titleStyle,
          ),
        ],
      ),
      initiallyExpanded: isExpanded,
      onExpansionChanged: onExpansionChanged,
      children: fixtureCount == 0
          ? [] // No need to display any child if there are no games
          : fixtures.asMap().entries.map((entry) {
        final match = entry.value;
        final formattedTime = DateFormat('HH:mm').format(match['date']);
        final homeTeam = match['homeTeam'];
        final awayTeam = match['awayTeam'];
        final homeTeamEmblem = match['homeTeamEmblem'];
        final awayTeamEmblem = match['awayTeamEmblem'];
        final String score = match['status'] == 'LIVE' || match['status'] == 'FINISHED'
            ? '${match['score']['home']} - ${match['score']['away']}'
            : 'Vs';

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Time Display
                  Text(
                    formattedTime,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  // Teams and Score Display
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          // Home Team Emblem
                          homeTeamEmblem.isNotEmpty
                              ? Image.network(
                            homeTeamEmblem,
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.sports_soccer, size: 20); // Placeholder if image fails to load
                            },
                          )
                              : SizedBox(width: 20, height: 20),
                          SizedBox(width: 8),
                          // Home Team Name
                          Text(
                            homeTeam,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 8),
                          // Score or "Vs"
                          Text(
                            score,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          // Away Team Name
                          Text(
                            awayTeam,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 8),
                          // Away Team Emblem
                          awayTeamEmblem.isNotEmpty
                              ? Image.network(
                            awayTeamEmblem,
                            width: 20,
                            height: 20,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.sports_soccer, size: 20); // Placeholder if image fails to load
                            },
                          )
                              : SizedBox(width: 20, height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (entry.key < fixtures.length) Divider(thickness: 1, color: Colors.grey), // Divider here
          ],
        );
      }).toList(),
    );
  }

}

