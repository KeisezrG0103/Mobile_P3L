import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/api_provider/forgot_password_provider.dart';
import 'package:untitled/ui/Customer_UI/Forgot_Password/VerifyOTP.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordProvider>(
      create: (context) => ForgotPasswordProvider(),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: COLOR.primaryColor,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: 'Please Enter '),
                          TextSpan(
                            text: 'Your Email',
                            style: TextStyle(
                              color: COLOR.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'To Receive An OTP To Create',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text: 'Your '),
                          TextSpan(
                            text: 'New Password.',
                            style: TextStyle(
                              color: COLOR.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 55.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE7E9F0),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    SizedBox( 
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_emailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Email Tidak Boleh Kosong!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          setState(() {
                            _isLoading = true;
                          });

                          final response = await provider.forgotPassword(_emailController.text);

                          setState(() {
                            _isLoading = false;
                          });

                         if (response.success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response.message),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/verify-otp', 
                                (Route<dynamic> route) => false,
                                arguments: _emailController.text,
                              );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: COLOR.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), 
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                'SEND',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}