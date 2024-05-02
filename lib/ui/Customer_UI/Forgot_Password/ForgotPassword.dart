import 'package:flutter/material.dart';
import 'package:untitled/constant/color.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                      text: 'New Password',
                      style: TextStyle(
                        color: COLOR.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 55.0),
              TextFormField(
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
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: COLOR.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                  ),
                  child: Text(
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
  }
}