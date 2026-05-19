class SignupResponse {
  final String token;
  final String message;

  const SignupResponse({
    required this.token,
    required this.message,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      token: json['token'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }
}
