// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class AuthService {
//   // Replace with your actual backend URL
//   static const String baseUrl =
//       'http://10.0.2.2:8080/api'; // For Android Emulator
//   // or 'http://localhost:3000/api' for iOS Simulator
//   // or your actual deployed backend URL like 'https://your-server.com/api'

//   Future<Map<String, dynamic>> login(String username, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({
//           'username': username,
//           'password': password,
//         }),
//       );

//       if (response.statusCode == 200) {
//         return json.decode(response.body);
//       } else {
//         throw Exception('Failed to login: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Connection error: $e');
//     }
//   }
// }
