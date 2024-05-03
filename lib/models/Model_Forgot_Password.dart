class ForgotPassword {
  final bool success;
  final String message;

  ForgotPassword({required this.success, required this.message});

  factory ForgotPassword.fromJson(Map<String, dynamic> json) {
    return ForgotPassword(
      success: json['success'],
      message: json['message'],
    );
  }
}