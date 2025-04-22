import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class LoginService {
  static const String _baseUrl = 'http://localhost:8080/api';
  static const int _timeoutDuration = 30;

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        return {
          'success': false,
          'error': 'Username and password are required'
        };
      }

      final url = Uri.parse('$_baseUrl/login');
      debugPrint('[LoginService] Attempting to connect to: ${url.toString()}');

      final body = jsonEncode({
        'username': username,
        'password': password,
      });

      debugPrint('[LoginService] Request body: $body');

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: body,
          )
          .timeout(Duration(seconds: _timeoutDuration));

      debugPrint('[LoginService] Response status: ${response.statusCode}');
      debugPrint('[LoginService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return {'success': true, 'token': data['token'], 'data': data};
        } else {
          return {
            'success': false,
            'error': data['error'] ?? 'Login failed',
            'details': data['details']
          };
        }
      } else {
        return {
          'success': false,
          'error': 'Server error: ${response.statusCode}',
          'details': response.body
        };
      }
    } on SocketException catch (e) {
      debugPrint('[LoginService] Connection error: $e');
      return {
        'success': false,
        'error':
            'Unable to connect to server. Please check your internet connection.'
      };
    } on TimeoutException catch (_) {
      debugPrint('[LoginService] Request timed out');
      return {
        'success': false,
        'error': 'Connection timed out. Please try again.'
      };
    } on FormatException catch (e) {
      debugPrint('[LoginService] Data format error: $e');
      return {'success': false, 'error': 'Invalid response format from server'};
    } catch (e) {
      debugPrint('[LoginService] Unexpected error: $e');
      return {
        'success': false,
        'error': 'An unexpected error occurred. Please try again.'
      };
    }
  }
}
