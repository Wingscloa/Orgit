import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final Logger _logger = Logger();

  /// Získá aktuální polohu uživatele
  Future<Position?> getCurrentLocation() async {
    try {
      // Zkontroluje, zda jsou povoleny lokační služby
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _logger.w('Location services are disabled');
        return null;
      }

      // Zkontroluje oprávnění k poloze
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _logger.w('Location permissions are denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _logger.e('Location permissions are permanently denied');
        return null;
      }

      // Získá aktuální polohu
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      );

      _logger
          .i('Current location: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e, stack) {
      _logger.e('Error getting current location: $e', stackTrace: stack);
      return null;
    }
  }

  /// Vypočítá vzdálenost mezi dvěma body v kilometrech
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000; // km
  }

  /// Převede název města na přibližné GPS souřadnice (pro démonstrace)
  /// V reálné aplikaci by se použila geokódovací služba
  Map<String, double>? getCityCoordinates(String city) {
    final cityCoordinates = {
      'děčín': {'lat': 50.7763, 'lon': 14.2142},
      'praha': {'lat': 50.0755, 'lon': 14.4378},
      'brno': {'lat': 49.1951, 'lon': 16.6068},
      'ostrava': {'lat': 49.8209, 'lon': 18.2625},
      'plzeň': {'lat': 49.7384, 'lon': 13.3736},
      'liberec': {'lat': 50.7664, 'lon': 15.0569},
      'olomouc': {'lat': 49.5938, 'lon': 17.2509},
      'ústí nad labem': {'lat': 50.6606, 'lon': 14.0322},
      'hradec králové': {'lat': 50.2103, 'lon': 15.8327},
      'české budějovice': {'lat': 48.9745, 'lon': 14.4742},
    };

    final normalizedCity = city.toLowerCase().trim();
    final coords = cityCoordinates[normalizedCity];

    if (coords != null) {
      return {'lat': coords['lat']!, 'lon': coords['lon']!};
    }

    _logger.w('Coordinates not found for city: $city');
    return null;
  }

  /// Zkontroluje, zda má aplikace oprávnění k poloze
  Future<bool> hasLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Požádá o oprávnění k poloze
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }
}
