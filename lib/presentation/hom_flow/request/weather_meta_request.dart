class WeatherMetaRequest {
  // CoverageModel coverageModel;
//final int page;
  final String? language;
  WeatherMetaRequest({this.language});

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = <String, dynamic>{
      'id':'10637'
    };
    return data;
  }
}