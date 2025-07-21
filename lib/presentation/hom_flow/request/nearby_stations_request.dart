class NearbyStationsRequest {
  final double latitude;
  final double longitude;
  final int? limit; // Maximum number of stations to return
  final double? radius; // Search radius in kilometers

  NearbyStationsRequest({
    required this.latitude,
    required this.longitude,
    this.limit = 5, // Default to 5 stations
    this.radius = 50.0, // Default to 50km radius
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = latitude;
    data['lon'] = longitude;
    if (limit != null) data['limit'] = limit;
    if (radius != null) data['radius'] = radius;
    return data;
  }
}
