import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_technique/Employee/Model/Employee.dart';

class EmployeeService {
  static const String baseUrl = 'http://63.250.52.98:9305';
  static const String addEmployeeEndpoint = '/persons/new';
  static const String getEmployeesEndpoint = '/persons';
  static const String updateEmployeeEndpoint = "/persons/upuserr";

  Future<void> addEmployee(Employee person) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + addEmployeeEndpoint),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(person.toJson()),
      );

      if (response.statusCode == 200) {
        print('Employee added successfully');
      } else {
        print('Failed to add employee: ${response.statusCode}');
        throw Exception('Failed to add employee');
      }
    } catch (e) {
      print('Exception during add employee: $e');
      rethrow;
    }
  }

  Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse(baseUrl + getEmployeesEndpoint));

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body)['content'];

      if (jsonData is List) {
        return jsonData.map((e) => Employee.fromJson(e)).toList();
      } else if (jsonData is Map<String, dynamic>) {
        return [Employee.fromJson(jsonData)];
      } else {
        throw Exception('Unexpected data format');
      }
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<Employee> getEmployeeById(int? id) async {
    final response =
        await http.get(Uri.parse('$baseUrl$getEmployeesEndpoint/$id'));

    if (response.statusCode == 200) {
      dynamic jsonData = json.decode(response.body);

      if (jsonData is Map<String, dynamic>) {
        return Employee.fromJson(jsonData);
      } else {
        throw Exception('Failed to parse employee data');
      }
    } else {
      throw Exception('Failed to load employee');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$updateEmployeeEndpoint/${employee.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(employee.toJson()),
      );

      if (response.statusCode == 200) {
        print('Employee updated successfully');
      } else {
        print('Failed to update employee: ${response.statusCode}');
        throw Exception('Failed to update employee');
      }
    } catch (e) {
      print('Exception during update employee: $e');
      rethrow;
    }
  }
}
