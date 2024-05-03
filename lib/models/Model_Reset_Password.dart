class ResetPassword {
  final bool success;
  final String message;

  ResetPassword({required this.success, required this.message});

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(
      success: json['success'],
      message: json['message'],
    );
  }
}