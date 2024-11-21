//
// // class CinemaList {
// //   final List<String> names;
// //   CinemaList({required this.names});
// // }
//
//
// // Cinema class to hold details of each cinema
// class Cinema {
//   final String name;
//   final String address;
//   final String avatarUrl; // URL or asset path for the logo/image
//
//   Cinema({required this.name, required this.address, required this.avatarUrl});
// }
//
// // CinemaList class that holds a list of cinemas
// class CinemaList {
//   final List<Cinema> cinemas;
//   CinemaList({required this.cinemas});
// }

// /lib/model/cinema_list.dart
class Cinema {
  final String name;
  final String address;
  final String logoUrl;
  final double latitude;
  final double longitude;

  Cinema({
    required this.name,
    required this.address,
    required this.logoUrl,
    required this.latitude,
    required this.longitude,
  });
}

class CinemaList {
  final List<Cinema> cinemas;

  CinemaList({required this.cinemas});
}

