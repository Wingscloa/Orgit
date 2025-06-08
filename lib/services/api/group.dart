import 'package:logger/logger.dart';
import 'package:orgit/models/group_dto.dart';
import 'package:orgit/services/api/api_client.dart';

/// Service class for group-related API operations with Firebase authentication
class GroupService {
  final ApiClient _apiClient = ApiClient();
  final Logger _logger = Logger();

  /// Fetch all groups
  Future<List<GroupResponse>> fetchGroups() async {
    try {
      final response = await _apiClient.get('/Group');

      if (response != null) {
        final List<dynamic> jsonGroups = response as List<dynamic>;
        return jsonGroups.map((json) => GroupResponse.fromJson(json)).toList();
      }

      throw Exception('Failed to load groups');
    } catch (e, stack) {
      _logger.e('Error fetching groups: $e', stackTrace: stack);
      throw Exception('Error fetching groups: $e');
    }
  }

  /// Create a new group
  Future<bool> createGroup(GroupCreateRequest groupRequest) async {
    try {
      final response = await _apiClient.post('/Group', groupRequest.toJson());

      if (response != null) {
        _logger.i('Group created successfully');
        return true;
      }

      return false;
    } catch (e, stack) {
      _logger.e('Error creating group: $e', stackTrace: stack);
      return false;
    }
  }

  /// Add user to group
  Future<bool> addUserToGroup(int userId, int groupId) async {
    try {
      final requestBody = {
        'userid': userId,
        'groupid': groupId,
      };

      final response = await _apiClient.post('/Group/member', requestBody);

      if (response != null) {
        _logger.i('User added to group successfully');
        return true;
      }

      return false;
    } catch (e, stack) {
      _logger.e('Error adding user to group: $e', stackTrace: stack);
      return false;
    }
  }

  /// Remove user from group
  Future<bool> removeUserFromGroup(int userId, int groupId) async {
    try {
      final requestBody = {
        'userid': userId,
        'groupid': groupId,
      };

      final response =
          await _apiClient.deleteWithBody('/Group/member', body: requestBody);

      if (response != null) {
        _logger.i('User removed from group successfully');
        return true;
      }

      return false;
    } catch (e, stack) {
      _logger.e('Error removing user from group: $e', stackTrace: stack);
      return false;
    }
  }

  /// Search groups with pagination
  Future<List<GroupSearchResponse>> searchGroups(int start, int count) async {
    try {
      final response = await _apiClient.get('/Groups/$start/$count');

      if (response != null) {
        final List<dynamic> jsonGroups = response as List<dynamic>;
        return jsonGroups
            .map((json) => GroupSearchResponse.fromJson(json))
            .toList();
      }

      return [];
    } catch (e, stack) {
      _logger.e('Error searching groups: $e', stackTrace: stack);
      throw Exception('Error searching groups: $e');
    }
  }

  /// Search groups by city
  Future<List<GroupSearchResponse>> searchGroupsByCity(
      String city, int start, int count) async {
    try {
      final response =
          await _apiClient.get('/Group/city/$city?start=$start&count=$count');

      if (response != null) {
        final List<dynamic> jsonGroups = response as List<dynamic>;
        return jsonGroups
            .map((json) => GroupSearchResponse.fromJson(json))
            .toList();
      }

      return [];
    } catch (e, stack) {
      _logger.e('Error searching groups by city: $e', stackTrace: stack);
      throw Exception('Error searching groups by city: $e');
    }
  }

  /// Search groups by name
  Future<List<GroupSearchResponse>> searchGroupsByName(
      String name, int start, int count) async {
    try {
      final response =
          await _apiClient.get('/Group/name/$name?start=$start&count=$count');

      if (response != null) {
        final List<dynamic> jsonGroups = response as List<dynamic>;
        return jsonGroups
            .map((json) => GroupSearchResponse.fromJson(json))
            .toList();
      }

      return [];
    } catch (e, stack) {
      _logger.e('Error searching groups by name: $e', stackTrace: stack);
      throw Exception('Error searching groups by name: $e');
    }
  }
}

// Global instance for backward compatibility with existing code
final GroupService _groupService = GroupService();

// Legacy functions that delegate to the service class
Future<List<GroupResponse>> fetchGroups() => _groupService.fetchGroups();
Future<bool> createGroup(GroupCreateRequest groupRequest) =>
    _groupService.createGroup(groupRequest);
Future<bool> addUserToGroup(int userId, int groupId) =>
    _groupService.addUserToGroup(userId, groupId);
Future<bool> removeUserFromGroup(int userId, int groupId) =>
    _groupService.removeUserFromGroup(userId, groupId);
Future<List<GroupSearchResponse>> searchGroups(int start, int count) =>
    _groupService.searchGroups(start, count);
Future<List<GroupSearchResponse>> searchGroupsByCity(
        String city, int start, int count) =>
    _groupService.searchGroupsByCity(city, start, count);
Future<List<GroupSearchResponse>> searchGroupsByName(
        String name, int start, int count) =>
    _groupService.searchGroupsByName(name, start, count);
