class VerifyOTP {
  final bool success;
  final String message;

  VerifyOTP({required this.success, required this.message});

  factory VerifyOTP.fromJson(Map<String, dynamic> json) {
    return VerifyOTP(
      success: json['success'],
      message: json['message'],
    );
  }
}