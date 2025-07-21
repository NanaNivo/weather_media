import 'package:geolocator/geolocator.dart';
import 'package:weather/core/error/custom_error.dart';
import 'package:weather/core/result/result.dart';
import 'package:weather/core/error/base_error.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  Future<Result<BaseError, Position>> getCurrentLocation() async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Result(
            error: CustomError(
                message:
                    'Location services are disabled. Please enable them in your device settings.'));
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Result(
              error: CustomError(
                  message:
                      'Location permissions are denied. Please enable them in your device settings.'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Result(
            error: CustomError(
                message:
                    'Location permissions are permanently denied. Please enable them in your device settings.'));
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return Result(data: position);
    } catch (e) {
      return Result(
          error:
              CustomError(message: 'Failed to get location: ${e.toString()}'));
    }
  }
}
