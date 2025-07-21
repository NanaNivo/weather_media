// Base API URL
const String endPointWeather = "https://meteostat.p.rapidapi.com";

// Stations endpoints
const String stationsNearby =
    "$endPointWeather/stations/nearby"; // Get stations by lat/long
const String stationsMeta =
    "$endPointWeather/stations/meta"; // Get station metadata
const String stationsHourly =
    "$endPointWeather/stations/hourly"; // Get hourly data
const String stationsDaily =
    "$endPointWeather/stations/daily";   // Get daily data
