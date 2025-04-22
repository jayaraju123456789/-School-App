import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class DashboardException implements Exception {
  final String message;
  final String? details;

  DashboardException(this.message, {this.details});

  @override
  String toString() => message;
}

class DashboardService {
  static const String baseUrl = 'http://10.0.2.2:8080/api';
  final String _token;

  DashboardService(this._token);

  Future<Map<String, dynamic>> getStudentData() async {
    try {
      developer.log('Fetching student data', name: 'DashboardService');

      final response = await http.get(
        Uri.parse('$baseUrl/student/dashboard'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw DashboardException('Connection timeout'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        throw DashboardException('Session expired, please login again');
      } else {
        throw DashboardException(
          'Failed to fetch data',
          details: 'Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      developer.log('Dashboard Error',
          name: 'DashboardService', error: e.toString());
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getChallenges() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/student/challenges'),
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw DashboardException('Failed to fetch challenges');
      }
    } catch (e) {
      throw DashboardException('Error loading challenges',
          details: e.toString());
    }
  }
}
