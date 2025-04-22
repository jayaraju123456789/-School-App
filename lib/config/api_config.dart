class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8080/api';
  static const Duration timeout = Duration(seconds: 30);

  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
        ...headers,
        'Authorization': 'Bearer $token',
      };
}
