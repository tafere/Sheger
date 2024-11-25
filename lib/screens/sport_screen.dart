import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Import to format dates

class SportScreen extends StatefulWidget {
  @override
  _SportScreenState createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> eplFixtures = [];
  bool isLoading = false; // Indicates whether data is currently being fetched
  List<DateTime> displayedDates = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    displayedDates = _generateWeekRange(selectedDate); // Generate the visible week range
    fetchEPLFixturesForDate(selectedDate); // Fetch fixtures for today's date
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(); // Scroll to the selected date after the UI is built
    });
  }

  // Helper function to generate a range of dates, now increments by 7 days
  List<DateTime> _generateWeekRange(DateTime baseDate) {
    final List<DateTime> dates = [];
    final startOfWeek = baseDate.subtract(Duration(days: baseDate.weekday - 1)); // Start of the week (Monday)
    for (int i = 0; i < 7; i++) {
      dates.add(startOfWeek.add(Duration(days: i))); // Increment by 7 days
    }
    return dates;
  }

  Future<void> fetchEPLFixturesForDate(DateTime date) async {
    setState(() {
      isLoading = true; // Start loading
      eplFixtures = []; // Clear existing fixtures to avoid stale data
    });

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

          return matchDateAddisAbaba.year == date.year &&
              matchDateAddisAbaba.month == date.month &&
              matchDateAddisAbaba.day == date.day;
        }).map((match) {
          final matchDateUtc = DateTime.parse(match['utcDate']);
          final matchDateAddisAbaba = matchDateUtc.add(Duration(hours: 3));

          final homeTeam = match['homeTeam']?['shortName'] ?? 'Unknown';
          final awayTeam = match['awayTeam']?['shortName'] ?? 'Unknown';
          final score = match['score']?['fullTime'] ?? {'home': null, 'away': null};
          final status = match['status'] ?? 'SCHEDULED';
          final homeTeamEmbelem = match['homeTeam']?['crest'] ?? '';
          final awayTeamEmbelem = match['awayTeam']?['crest'] ?? '';

          return {
            'homeTeam': homeTeam,
            'awayTeam': awayTeam,
            'date': matchDateAddisAbaba,
            'status': status,
            'score': score,
            'homeTeamEmbelem': homeTeamEmbelem,
            'awayTeamEmbelem': awayTeamEmbelem,
          };
        }).toList();

        setState(() {
          eplFixtures = filteredMatches;
        });
      } else {
        throw Exception('Failed to load fixtures');
      }
    } catch (e) {
      print('Error fetching fixtures: $e');
    } finally {
      setState(() {
        isLoading = false; // Fetching is complete
      });
    }
  }

  // Change date when user selects a date (increments by 7 days)
  void _changeDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
      displayedDates = _generateWeekRange(newDate); // Update displayed week
    });
    fetchEPLFixturesForDate(selectedDate); // Fetch fixtures for the new date
  }


  // Scroll the ListView to the selected date
  void _scrollToSelectedDate() {
    final index = displayedDates.indexOf(selectedDate);
    if (index != -1) {
      _scrollController.animateTo(
        index * (MediaQuery.of(context).size.width / 7), // Adjust scroll distance to fit 7 items
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Navigate to the previous week
  void _previousWeek() {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 7)); // Move back 7 days
      displayedDates = _generateWeekRange(selectedDate); // Update the displayed week range
    });
    fetchEPLFixturesForDate(selectedDate); // Fetch fixtures for the new date
  }

  // Navigate to the next week
  void _nextWeek() {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 7)); // Move forward 7 days
      displayedDates = _generateWeekRange(selectedDate); // Update the displayed week range
    });
    fetchEPLFixturesForDate(selectedDate); // Fetch fixtures for the new date
  }

  // Navigate to the previous month
  void _previousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1, 1); // Move to the first day of the previous month
      displayedDates = _generateWeekRange(selectedDate); // Update the displayed week range
    });
    fetchEPLFixturesForDate(selectedDate); // Fetch fixtures for the new date
  }

  // Navigate to the next month
  void _nextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1, 1); // Move to the first day of the next month
      displayedDates = _generateWeekRange(selectedDate); // Update the displayed week range
    });
    fetchEPLFixturesForDate(selectedDate); // Fetch fixtures for the new date
  }

  @override
  Widget build(BuildContext context) {
    // Get the month name (e.g., December)
    String monthName = DateFormat('MMMM').format(selectedDate);

    // Calculate the size of each day button to fit the screen with 7 days
    double buttonSize = MediaQuery.of(context).size.width / 7;

    return Scaffold(
      appBar: AppBar(
        title: Text('English Premier League'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Row for Previous and Next month buttons and current month display
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: _previousWeek,
                ),
                Text(
                  monthName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: _nextWeek,
                ),
              ],
            ),
          ),
          // Horizontally scrollable date selection (First Initial + Date)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: buttonSize, // Set height to make it square
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: displayedDates.length, // Dynamically show 7 days for the week
                itemBuilder: (context, index) {
                  DateTime date = displayedDates[index];

                  // Get the first initial of the day (e.g., "M" for Monday)
                  String dayAbbreviation = DateFormat('E').format(date).substring(0, 1); // Get initial
                  String formattedDate = DateFormat('dd').format(date); // Show day of the month (dd)

                  return GestureDetector(
                    onTap: () => _changeDate(date),
                    child: Container(
                      width: buttonSize - 1 / 5 * buttonSize, // Ensure buttons are square
                      height: buttonSize - 1 / 5 * buttonSize, // Set height to make it square
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Smaller padding
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: selectedDate == date ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: selectedDate == date ? Colors.blue : Colors.grey,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dayAbbreviation, // Day initial (M, T, W, etc.)
                              style: TextStyle(
                                color: selectedDate == date ? Colors.white : Colors.black,
                                fontSize: 10, // Reduced font size for initials
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedDate, // Date (e.g., "12")
                              style: TextStyle(
                                color: selectedDate == date ? Colors.white : Colors.black,
                                fontSize: 12, // Reduced font size for date
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Fixture list or "No games" message
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : eplFixtures.isEmpty
                ? Center(child: Text('No games for this month.', style: TextStyle(fontSize: 18)))
                : ListView.builder(
              itemCount: eplFixtures.length,
              itemBuilder: (context, index) {
                final match = eplFixtures[index];
                final formattedTime = DateFormat('HH:mm').format(match['date']);

                // Safely retrieve the scores, using '-' if null
                final finalHomeScore = match['score']?['home']?.toString() ?? '-';
                final finalAwayScore = match['score']?['away']?.toString() ?? '-';

                // Check if the match is live or finished
                final bool isLiveOrFinished = match['status'] == 'LIVE' || match['status'] == 'FINISHED';
                final String scoreDisplay = isLiveOrFinished ? '$finalHomeScore - $finalAwayScore' : 'Vs';

                // Remove "FC" from team names
                final homeTeam = match['homeTeam']?.replaceAll(' FC', '') ?? 'Home';
                final awayTeam = match['awayTeam']?.replaceAll(' FC', '') ?? 'Away';
                final homeTeamEmbelem = match['homeTeamEmbelem'];
                final awayTeamEmbelem = match['awayTeamEmbelem'];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
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
                              child: Row(
                                children: [
                                  // Home Team Emblem
                                  homeTeamEmbelem.isNotEmpty
                                      ? Image.network(
                                    homeTeamEmbelem,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  )
                                      : SizedBox(width: 30, height: 30),
                                  SizedBox(width: 8), // Space between emblem and team name
                                  Text(
                                    '$homeTeam',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  SizedBox(width: 8), // Space between team names
                                  Text(scoreDisplay),
                                  SizedBox(width: 8), // Space between team names and away team
                                  Text(
                                    '$awayTeam',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  SizedBox(width: 8), // Space between team names and emblem
                                  // Away Team Emblem
                                  awayTeamEmbelem.isNotEmpty
                                      ? Image.network(
                                    awayTeamEmbelem,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  )
                                      : SizedBox(width: 30, height: 30),
                                ],
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

