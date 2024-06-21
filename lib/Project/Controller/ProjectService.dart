import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_technique/Project/Model/Project.dart';

class ProjectService {
  static const String baseUrl = 'http://63.250.52.98:9305';
  static const String addProjectEndpoint = '/projects/create';

  Future<void> addProject(Project project) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + addProjectEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(project.toJson()),
      );

      if (response.statusCode == 200) {
        print('Project added successfully');
      } else {
        print('Failed to add project: ${response.statusCode}');
        throw Exception('Failed to add project');
      }
    } catch (e) {
      print('Exception during add project: $e');
      rethrow;
    }
  }

  Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body)['content'];

      if (jsonData is List) {
        return jsonData.map((e) => Project.fromJson(e)).toList();
      } else if (jsonData is Map<String, dynamic>) {
        return [Project.fromJson(jsonData)];
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<List<Project>> fetchProjectsAffectedToUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/projectsdone/all'));

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body)['content'];

      if (jsonData is List) {
        return jsonData.map((e) => Project.fromJson(e)).toList();
      } else if (jsonData is Map<String, dynamic>) {
        return [Project.fromJson(jsonData)];
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Failed to load projects affected');
    }
  }

  Future<void> affectProjectToUsers(int projectId, List<UserItem> users) async {
    try {
      final url = Uri.parse('$baseUrl/projectsdone/UsersProject');

      Map<String, dynamic> requestBody = {
        "project": {"idpro": projectId},
        "list": users
            .map((user) => {"id": user.id, "itemName": user.itemName})
            .toList(),
      };

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Project affected to users successfully');
      } else {
        throw Exception('Failed to affect project to users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

class UserItem {
  final int id;
  final String itemName;

  UserItem({required this.id, required this.itemName});
}
