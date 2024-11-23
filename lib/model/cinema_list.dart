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

