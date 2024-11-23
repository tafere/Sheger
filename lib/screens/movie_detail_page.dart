// import 'package:flutter/material.dart';
// import '../model/movie_detail.dart';
//
// class MovieDetailPage extends StatelessWidget {
//   final MovieDetail movieDetail;
//
//   MovieDetailPage({required this.movieDetail});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           movieDetail.title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//           ),
//         ),
//         backgroundColor: Colors.teal, // Modern app bar color
//         elevation: 0, // No shadow for the app bar for a clean look
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Movie Poster (fills horizontal space, no gap with AppBar)
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.4, // Half screen height
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(movieDetail.posterUrl),
//                   fit: BoxFit.cover, // Ensures the image stretches across
//                 ),
//                 borderRadius: BorderRadius.zero, // No rounded corners
//               ),
//             ),
//             SizedBox(height: 20), // Space between poster and showtimes
//
//             // Showtimes Section Heading (Outside of card)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Showtimes',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.teal, // Accent color
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Space between heading and showtimes list
//
//             // List of showtimes using ListTile for clean, end-to-end layout
//             Column(
//               children: movieDetail.showtimes.map((showtime) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.deepPurple,
//                     child: Icon(Icons.local_movies, color: Colors.white),
//                   ),
//                   title: Text(
//                     showtime.cinema,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87, // Dark text for contrast
//                     ),
//                   ),
//                   subtitle: Text(
//                     showtime.times.join('  •  '), // Join multiple times with a bullet separator
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[700], // Subtle grey for times
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import '../model/movie_detail.dart';
//
// class MovieDetailPage extends StatelessWidget {
//   final MovieDetail movieDetail;
//
//   MovieDetailPage({required this.movieDetail});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           movieDetail.title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//           ),
//         ),
//         backgroundColor: Colors.teal, // Modern app bar color
//         elevation: 0, // No shadow for the app bar for a clean look
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Movie Poster (fills horizontal space, no gap with AppBar)
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.4, // Half screen height
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(movieDetail.posterUrl),
//                   fit: BoxFit.contain, // Ensures the image is fully shown without cropping
//                 ),
//                 borderRadius: BorderRadius.zero, // No rounded corners
//               ),
//             ),
//             SizedBox(height: 20), // Space between poster and showtimes
//
//             // Showtimes Section Heading (Outside of card)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Showtimes',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.teal, // Accent color
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Space between heading and showtimes list
//
//             // List of showtimes using ListTile for clean, end-to-end layout
//             Column(
//               children: movieDetail.showtimes.map((showtime) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.deepPurple,
//                     child: Icon(Icons.local_movies, color: Colors.white),
//                   ),
//                   title: Text(
//                     showtime.cinema,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87, // Dark text for contrast
//                     ),
//                   ),
//                   subtitle: Text(
//                     showtime.times.join('  •  '), // Join multiple times with a bullet separator
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[700], // Subtle grey for times
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import '../model/movie_detail.dart';
//
// class MovieDetailPage extends StatelessWidget {
//   final MovieDetail movieDetail;
//
//   MovieDetailPage({required this.movieDetail});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           movieDetail.title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//           ),
//         ),
//         backgroundColor: Colors.teal, // Modern app bar color
//         elevation: 0, // No shadow for the app bar for a clean look
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Movie Poster (fills horizontal space, no gap with AppBar)
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.4, // Half screen height
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(movieDetail.posterUrl),
//                   fit: BoxFit.fitWidth, // Ensures the image fills the width without cropping
//                 ),
//                 borderRadius: BorderRadius.zero, // No rounded corners
//               ),
//             ),
//             SizedBox(height: 20), // Space between poster and showtimes
//
//             // Showtimes Section Heading (Outside of card)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 'Showtimes',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.teal, // Accent color
//                 ),
//               ),
//             ),
//             SizedBox(height: 10), // Space between heading and showtimes list
//
//             // List of showtimes using ListTile for clean, end-to-end layout
//             Column(
//               children: movieDetail.showtimes.map((showtime) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.deepPurple,
//                     child: Icon(Icons.local_movies, color: Colors.white),
//                   ),
//                   title: Text(
//                     showtime.cinema,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87, // Dark text for contrast
//                     ),
//                   ),
//                   subtitle: Text(
//                     showtime.times.join('  •  '), // Join multiple times with a bullet separator
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[700], // Subtle grey for times
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import '../model/movie_detail.dart';
//
// class MovieDetailPage extends StatelessWidget {
//   final MovieDetail movieDetail;
//
//   MovieDetailPage({required this.movieDetail});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           // SliverAppBar keeps the movie poster fixed and lets the rest scroll
//           SliverAppBar(
//             expandedHeight: MediaQuery.of(context).size.height * 0.4, // Poster height
//             floating: false,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Image.asset(
//                 movieDetail.posterUrl,
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     'Showtimes',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.teal,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // List of cinemas with a divider between them
//                 ...movieDetail.showtimes.map((showtime) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Divider
//                       Divider(
//                         thickness: 1,
//                         color: Colors.grey[300],
//                         indent: 16,
//                         endIndent: 16,
//                       ),
//                       // Cinema Name and Showtimes wrapped in a Button
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 16),
//                             backgroundColor: Colors.teal, // Button color
//                           ),
//                           onPressed: () {
//                             // Handle button click (e.g., show details for that cinema)
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // Cinema Logo (example using an icon, replace with actual logo)
//                               CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 child: Icon(Icons.local_movies, color: Colors.teal),
//                               ),
//                               // Cinema Name and Showtimes
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     showtime.cinema,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   Text(
//                                     showtime.times.join(' • '), // Join times with a bullet separator
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white70,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../model/movie_detail.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieDetail movieDetail;

  MovieDetailPage({required this.movieDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar keeps the movie poster fixed and lets the rest scroll
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4, // Poster height
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                movieDetail.posterUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Showtimes',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // List of cinemas with a divider between them
                ...movieDetail.showtimes.map((showtime) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Divider
                      Divider(
                        thickness: 1,
                        color: Colors.grey[300],
                        indent: 16,
                        endIndent: 16,
                      ),
                      // Cinema Name and Showtimes displayed normally
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Cinema Logo (using an icon here, replace with actual logo if needed)
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.local_movies, color: Colors.teal),
                            ),
                            SizedBox(width: 16),
                            // Cinema Name and Showtimes
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  showtime.cinema,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  showtime.times.join(' • '), // Join times with a bullet separator
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
