import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/todo.dart';
import 'config.dart';

class TodoApiService {
  static const String baseUrl = API.baseURL;
  static Future<List<Todo>> getTodos(int userId) async {
    try {
      print('Calling API: $baseUrl/Todo/$userId');
      final response = await http.get(
        Uri.parse('$baseUrl/Todo/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.tempToken}',
        },
      ).timeout(Duration(seconds: 10));

      print('API Response status: ${response.statusCode}');
      print('API Response body: ${response.body}');

      if (response.statusCode == 200) {
        // API vrací jeden objekt, ne array
        final Map<String, dynamic> data = json.decode(response.body);
        return [Todo.fromJson(data)];
      } else if (response.statusCode == 404) {
        // Uživatel nemá žádné todos
        print('User has no todos');
        return [];
      } else {
        throw Exception('Failed to load todos: ${response.statusCode}');
      }
    } catch (e) {
      // Pokud je to network error, vrátíme prázdný seznam
      print('Error loading todos: $e');
      return [];
    }
  }

  static Future<Todo> createTodo(Todo todo) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Todo'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.tempToken}',
        },
        body: json.encode({
          'userid': todo.userId,
          'title': todo.title,
          'note': todo.note,
          'whencomplete': todo.whenComplete.toIso8601String(),
          'tocomplete': todo.toComplete?.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        // API vrací jen success message, vytvoříme todo objekt
        return todo.copyWith(todoId: DateTime.now().millisecondsSinceEpoch);
      } else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create todo: $e');
    }
  }

  static Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/Todo'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.tempToken}',
        },
        body: json.encode({
          'todoid': todo.todoId,
          'title': todo.title,
          'note': todo.note,
          'whencomplete': todo.whenComplete.toIso8601String(),
          'tocomplete': todo.toComplete?.toIso8601String(),
        }),
      );

      if (response.statusCode == 201) {
        return todo;
      } else {
        throw Exception('Failed to update todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  static Future<void> deleteTodo(int todoId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/Todo/$todoId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${API.tempToken}',
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to delete todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
