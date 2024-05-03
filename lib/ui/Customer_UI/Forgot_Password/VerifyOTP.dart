import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/api_provider/forgot_password_provider.dart';
import 'package:untitled/ui/Customer_UI/Forgot_Password/ChangePassword.dart';

class VerifyOTPScreen extends StatefulWidget {
  final String email;

  const VerifyOTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpController = TextEditingController();
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
                      'Enter Your OTP',
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
                          TextSpan(text: 'Please'),
                          TextSpan(
                            text: ' Check And Enter',
                            style: TextStyle(
                              color: COLOR.primaryColor,
                            ),
                          ),
                        ],
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
                          TextSpan(text: 'Your'),
                          TextSpan(
                            text: ' OTP',
                            style: TextStyle(
                              color: COLOR.primaryColor,
                            ),
                          ),
                           TextSpan(text: ' In'),
                           TextSpan(
                            text: ' ${widget.email}',
                            style: TextStyle(
                              color: COLOR.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      controller: _otpController,
                      maxLength: 6, 
                      keyboardType: TextInputType.number, 
                      decoration: InputDecoration(
                        labelText: 'OTP',
                        counterText: '', 
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE7E9F0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'OTP cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_otpController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('OTP tidak boleh kosong'), 
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          setState(() {
                            _isLoading = true;
                          });
                          final response = await provider.verifyOTP(widget.email, _otpController.text);
                          setState(() {
                            _isLoading = false;
                          });

                        
                          if (response.success) {
                           
                            print(response.message);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response.message),
                                backgroundColor: Colors.green,
                              ),
                            );

                             Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(email: widget.email),
                              ),
                            );
                          } else {
                           
                            print(response.message);
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
                                'NEXT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
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