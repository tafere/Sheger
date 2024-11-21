import 'package:flutter/material.dart';
import 'package:my_new_flutter_project/model/movie_detail.dart';
import 'package:my_new_flutter_project/screens/movie_detail_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedBottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu, color: Colors.white),
          title: Text(
            'Sheger Events',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.search, color: Colors.white),
            ),
            Icon(Icons.more_vert, color: Colors.white),
          ],
          backgroundColor: Color(0xff00695c),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: 'Movies', icon: Icon(Icons.movie)),
              Tab(text: 'Sport', icon: Icon(Icons.sports_soccer_rounded)),
              Tab(text: 'Festival', icon: Icon(Icons.celebration_outlined)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildMoviesTab(),
            Center(
              child: Text(
                'Sport Content Coming Soon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Text(
                'Public Festival Content Coming Soon',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesTab() {
    return Scaffold(
      body: _selectedBottomNavIndex == 0 ? _buildMoviesList() : _buildCinemaList(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.theaters),
            label: 'Cinema',
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesList() {
    // List of Amharic movies with showtimes
    final List<MovieDetail> amharicMovies = [
      MovieDetail(
        title: 'Fikir Sifered',
        posterUrl: 'assets/images/fikirSiferd.jpeg',
        showtimes: [
          CinemaShowtime(cinema: 'Alem Cinema', times: ['1:00 PM', '4:30 PM']),
          CinemaShowtime(cinema: 'Sebastopol', times: ['2:00 PM', '7:00 PM']),
          CinemaShowtime(cinema: 'Ethiopia', times: ['3:00 PM', '8:00 PM']),
          CinemaShowtime(cinema: 'Empire', times: ['11:00 AM', '3:00 PM']),
          CinemaShowtime(cinema: 'EdnaMall', times: ['4:00 AM', '6:00 PM', '9:00 PM']),
          CinemaShowtime(cinema: 'Adwa', times: ['11:00 AM', '3:00 PM']),
          CinemaShowtime(cinema: 'Sheger', times: ['4:00 AM', '6:00 PM', '9:00 PM']),
        ],
      ),
      MovieDetail(
        title: 'Azamed',
        posterUrl: 'assets/images/Azamed.jpg',
        showtimes: [
          CinemaShowtime(cinema: 'Sevastopol', times: ['12:00 PM', '3:00 PM']),
          CinemaShowtime(cinema: 'Ethiopia', times: ['3:00 PM', '8:00 PM']),
          CinemaShowtime(cinema: 'Empire', times: ['11:00 AM', '3:00 PM']),
          CinemaShowtime(cinema: 'EdnaMall', times: ['4:00 AM', '6:00 PM', '9:00 PM']),
          CinemaShowtime(cinema: 'Adwa', times: ['11:00 AM', '3:00 PM']),
          CinemaShowtime(cinema: 'Sheger', times: ['4:00 AM', '6:00 PM', '9:00 PM']),
        ],
      ),
    ];

    // List of English movies with showtimes
    final List<MovieDetail> englishMovies = [
      MovieDetail(
        title: 'The Marvels',
        posterUrl: 'assets/images/the_marvels.jpg',
        showtimes: [
          CinemaShowtime(cinema: 'Ethiopia Cinema', times: ['10:00 AM', '7:00 PM']),
        ],
      ),
      MovieDetail(
        title: 'Mission Impossible',
        posterUrl: 'assets/images/mission_impossible.jpg',
        showtimes: [
          CinemaShowtime(cinema: 'Alem Cinema', times: ['2:00 PM', '9:00 PM']),
        ],
      ),
    ];

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Expandable list for Amharic Movies
        ExpansionTile(
          title: Text('Amharic Movies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          children: amharicMovies.map((movie) {
            return ListTile(
              title: Text(movie.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movieDetail: movie),
                  ),
                );
              },
            );
          }).toList(),
        ),

        // Expandable list for English Movies
        ExpansionTile(
          title: Text('English Movies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          children: englishMovies.map((movie) {
            return ListTile(
              title: Text(movie.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movieDetail: movie),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCinemaList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('A'),
          ),
          title: Text('Alem Cinema'),
          subtitle: Text('Address: Piassa, Addis Ababa'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('S'),
          ),
          title: Text('Sevastopol Cinema'),
          subtitle: Text('Address: Kazanchis, Addis Ababa'),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange,
            child: Text('E'),
          ),
          title: Text('Ethiopia Cinema'),
          subtitle: Text('Address: Bole, Addis Ababa'),
        ),
      ],
    );
  }
}
