class PlaceModel {
  final String displayName;
  final double latitude;
  final double longitude;

  const PlaceModel({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  factory PlaceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PlaceModel(
      displayName: json['display_name'] ?? '',
      latitude: double.parse(json['lat']),
      longitude: double.parse(json['lon']),
    );
  }
}
