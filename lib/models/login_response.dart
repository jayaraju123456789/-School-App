class LoginResponse {
  final bool success;
  final String? token;
  final String? error;
  final int? studentLevel;
  final int? xpPoints;
  final int? challengeStreak;

  LoginResponse({
    required this.success,
    this.token,
    this.error,
    this.studentLevel,
    this.xpPoints,
    this.challengeStreak,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      token: json['token'],
      error: json['error'],
      studentLevel: json['studentLevel'],
      xpPoints: json['xpPoints'],
      challengeStreak: json['challengeStreak'],
    );
  }

  factory LoginResponse.error(String message) {
    return LoginResponse(
      success: false,
      error: message,
    );
  }
}
