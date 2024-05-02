import 'package:flutter/material.dart';
import 'package:untitled/constant/color.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'Please'),
                    TextSpan(
                      text: ' Check and Enter',
                      style: TextStyle(
                        color: COLOR.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
                RichText(
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
                    TextSpan(text: ' In Your'),
                    TextSpan(
                      text: ' Email.',
                      style: TextStyle(
                        color: COLOR.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 50.0),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6, // Memastikan panjang maksimal 6 digit
                decoration: InputDecoration(
                  labelText: 'OTP',
                  hintText: 'Enter OTP here',
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
                  onPressed: () {
                     Navigator.pushNamedAndRemoveUntil(context,
                                      '/change-password', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: COLOR.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                  ),
                  child: Text(
                    'NEXT',
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
  }
}