class WeatherHourlyDailyRequest {
  final String? language;
  final String? station; // Station ID
  final String? start; // Start date in YYYY-MM-DD format
  final String? end; // End date in YYYY-MM-DD format
  final String? units; // Metric or imperial

  WeatherHourlyDailyRequest({
    this.language,
    this.station,
    this.start,
    this.end,
    this.units,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (station != null) data['station'] = station;
    if (start != null) data['start'] = start;
    if (end != null) data['end'] = end;
    if (units != null) data['units'] = units;

    return data;
  }
}
