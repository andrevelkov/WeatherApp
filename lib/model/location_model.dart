
class LocationModel {
  final String city;
  final String country;
  final String? state;
  final double latitude;
  final double longitude;

  LocationModel({
    required this.city,
    required this.country,
    required this.state,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      city: json['name'],
      country: json['country'],
      state: json['state'],
      latitude: json['lat'],
      longitude: json['lon'],
    );
  }

}