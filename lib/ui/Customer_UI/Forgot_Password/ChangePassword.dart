import 'package:flutter/material.dart';
import 'package:untitled/constant/color.dart';
import 'package:provider/provider.dart';
import 'package:untitled/api_provider/forgot_password_provider.dart';
import 'package:untitled/ui/LoginScreen.dart';

class ChangePasswordScreen extends StatefulWidget {

  final String email;

  const ChangePasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmedPasswordController;
  bool _isLoading = false;
  bool _isObscure = true; 

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmedPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordProvider>(
      create: (context) => ForgotPasswordProvider(),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView( 
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'New Password',
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
                            TextSpan(text: 'Yay! You Can'),
                            TextSpan(
                              text: ' Enter',
                              style: TextStyle(
                                color: COLOR.primaryColor,
                              ),
                            ),
                            TextSpan(text: ' Your'),
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
                            TextSpan(
                              text: 'New Password',
                              style: TextStyle(
                                color: COLOR.primaryColor,
                              ),
                            ),
                            TextSpan(text: ' Now.'),
                          ],
                        ),
                      ),
                      SizedBox(height: 50.0),
                      TextFormField(
                        controller: _newPasswordController,
                        obscureText: _isObscure, 
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFE7E9F0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off, 
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure; 
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: _confirmedPasswordController,
                        obscureText: _isObscure, 
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Color(0xFFE7E9F0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off, 
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure; 
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_newPasswordController.text.isEmpty || _confirmedPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Password / Confirmed Password tidak boleh kosong'), 
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            final response = await provider.resetPassword(widget.email, _newPasswordController.text, _confirmedPasswordController.text);
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

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/login', 
                                  (Route<dynamic> route) => false,
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
            ),
          );
        }
      )
    );
  }
}