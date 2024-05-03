import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:untitled/models/Model_Forgot_Password.dart';
import 'package:untitled/models/Model_Verify_OTP.dart';
import 'package:untitled/constant/url.dart';

class ForgotPasswordProvider extends ChangeNotifier {


    Future<ForgotPassword> forgotPassword(String email) async {

      final url = Uri.parse(URL.FORGOT);
      final response = await http.post(
        url,
        body: {'email': email},
      );

      if (response.statusCode == 200) {
          
          return ForgotPassword.fromJson(jsonDecode(response.body));

      } else {
        
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final errorMessage = responseData['message'] as String;
      
          return ForgotPassword(success: false, message: errorMessage);

      }

   }

    Future<VerifyOTP> verifyOTP(String email, String otp) async {

        final url = Uri.parse(URL.VERIFY);
        final response = await http.post(
          url,
          body: {'email': email, 'token': otp},
        );

        if (response.statusCode == 200) {
        
          return VerifyOTP.fromJson(jsonDecode(response.body));
        } else {
        
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final errorMessage = responseData['message'] as String;
       
          return VerifyOTP(success: false, message: errorMessage);
        
      }
  
   }


       Future<VerifyOTP> resetPassword(String email, String password, String confirmedPassword) async {

        final url = Uri.parse(URL.RESET);
        final response = await http.post(
          url,
          body: {'email': email, 'password': password, 'password_confirmation': confirmedPassword},
        );

        if (response.statusCode == 200) {
        
          return VerifyOTP.fromJson(jsonDecode(response.body));
        } else {
        
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final errorMessage = responseData['message'] as String;
       
          return VerifyOTP(success: false, message: errorMessage);
        
      }
  
   }

}

