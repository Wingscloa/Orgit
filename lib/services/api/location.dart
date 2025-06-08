import 'package:logger/logger.dart';
import 'package:orgit/services/api/api_client.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final ApiClient _apiClient = ApiClient();
  final Logger _logger = Logger();

  /// Get all regions
  Future<List<RegionDto>> getRegions() async {
    try {
      final response = await _apiClient.get('/Regions');
      if (response != null) {
        final List<dynamic> jsonRegions = response as List<dynamic>;
        return jsonRegions.map((json) => RegionDto.fromJson(json)).toList();
      }
      return [];
    } catch (e, stack) {
      _logger.e('Error fetching regions: $e', stackTrace: stack);
      throw Exception('Error fetching regions: $e');
    }
  }

  /// Get all cities
  Future<List<CityDto>> getCities() async {
    try {
      final response = await _apiClient.get('/Cities');
      if (response != null) {
        final List<dynamic> jsonCities = response as List<dynamic>;
        return jsonCities.map((json) => CityDto.fromJson(json)).toList();
      }
      return [];
    } catch (e, stack) {
      _logger.e('Error fetching cities: $e', stackTrace: stack);
      throw Exception('Error fetching cities: $e');
    }
  }

  /// Get cities by region ID
  Future<List<CityDto>> getCitiesByRegion(int regionId) async {
    try {
      final response = await _apiClient.get('/Cities/region/$regionId');
      if (response != null) {
        final List<dynamic> jsonCities = response as List<dynamic>;
        return jsonCities.map((json) => CityDto.fromJson(json)).toList();
      }
      return [];
    } catch (e, stack) {
      _logger.e('Error fetching cities by region: $e', stackTrace: stack);
      throw Exception('Error fetching cities by region: $e');
    }
  }

  /// Get region by ID
  Future<RegionDto?> getRegionById(int regionId) async {
    try {
      final response = await _apiClient.get('/Region/$regionId');
      if (response != null) {
        return RegionDto.fromJson(response);
      }
      return null;
    } catch (e, stack) {
      _logger.e('Error fetching region by ID: $e', stackTrace: stack);
      throw Exception('Error fetching region by ID: $e');
    }
  }

  /// Get city by ID
  Future<CityDto?> getCityById(int cityId) async {
    try {
      final response = await _apiClient.get('/City/$cityId');
      if (response != null) {
        return CityDto.fromJson(response);
      }
      return null;
    } catch (e, stack) {
      _logger.e('Error fetching city by ID: $e', stackTrace: stack);
      throw Exception('Error fetching city by ID: $e');
    }
  }
}

class RegionDto {
  final int regionid;
  final String name;

  RegionDto({
    required this.regionid,
    required this.name,
  });
  factory RegionDto.fromJson(Map<String, dynamic> json) {
    return RegionDto(
      regionid: json['regionid'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'regionid': regionid,
      'name': name,
    };
  }
}

class CityDto {
  final int cityId;
  final String name;
  final int regionid;

  CityDto({
    required this.cityId,
    required this.name,
    required this.regionid,
  });
  factory CityDto.fromJson(Map<String, dynamic> json) {
    return CityDto(
      cityId: json['cityid'] ?? 0, // Note: API returns 'cityid' not 'CityId'
      name: json['name'] ?? '',
      regionid: json['regionid'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cityid': cityId, // Note: API expects 'cityid' not 'CityId'
      'name': name,
      'regionid': regionid,
    };
  }
}
