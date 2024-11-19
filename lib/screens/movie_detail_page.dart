import 'package:flutter/material.dart';
import '../model/movie_detail.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieDetail movieDetail;

  MovieDetailPage({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movieDetail.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        backgroundColor: Colors.deepOrangeAccent, // Modern app bar color
        elevation: 0, // No shadow for the app bar for a clean look
      ),
      body: SingleChildScrollView( // To ensure everything fits on screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster (Image) - Full width and no rounded corners
              Container(
                height: 350, // Large poster image size
                width: double.infinity, // Full width of screen
                decoration: BoxDecoration(
                  // No rounded corners, full screen width
                  borderRadius: BorderRadius.zero,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage(movieDetail.posterUrl), // Use local image
                    fit: BoxFit.cover, // Ensure it covers the space
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between image and title

              // Showtimes Section Heading
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Showtimes',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent, // Modern accent color
                  ),
                ),
              ),

              // List of showtimes with dividers (white background and separated by lines)
              ListView.separated(
                shrinkWrap: true, // Prevents the list from taking up extra space
                physics: NeverScrollableScrollPhysics(), // Prevents scrolling for this list
                itemCount: movieDetail.showtimes.length,
                itemBuilder: (context, index) {
                  var showtime = movieDetail.showtimes[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                    color: Colors.white, // White background for each showtime
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          showtime.cinema,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87, // Dark text for contrast
                          ),
                        ),
                        Text(
                          showtime.times.join('   '), // Joining multiple times
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700], // Subtle grey for times
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider( // Divider between showtimes
                    color: Colors.grey[300], // Subtle gray divider
                    height: 1,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
