import 'package:flutter/material.dart';
import 'package:untitled/bloc/auth_bloc.dart';
import 'package:untitled/constant/color.dart';
import 'package:localstorage/localstorage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _NamaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String token = "";
  late String role = "";
  final LocalStorage storage = LocalStorage('localstorage_app');

  bool isVisible = false;

  bool isKaryawan = false;

  @override
  void initState() {
    super.initState();
    isVisible = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _NamaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image Container
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/asset_1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Logo Container
          Positioned(
            top: MediaQuery.of(context).size.height / 5 - 100,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: AssetImage('assets/coba.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Login Form Container
          Login(context),
        ],
      ),
    );
  }

  Positioned Login(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 3 / 5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: COLOR.primaryColor,
                  ),
                ),
              ),

              // Email Field
              const SizedBox(height: 10),
              TextFormField(
                controller: isKaryawan ? _NamaController : _emailController,
                decoration: InputDecoration(
                  labelText: isKaryawan ? 'Nama' : 'Email',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: !isVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Forgot Password Text
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: Text(
                      'Forgot Your Password?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isKaryawan = !isKaryawan;
                      });
                    },
                    child: Text(
                      isKaryawan ? 'Login as Customer' : 'Login as Karyawan',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isKaryawan) {
                      final Nama = _NamaController.text;
                      final password = _passwordController.text;
                      Auth_bloc.loginKaryawanFn(Nama, password);

                      Auth_bloc.loginKaryawan.listen((event) {
                        token = event.token;
                        role = event.role;
                        print("token karyawan: $token");
                        if (token.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login Failed'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          if (role == "MO") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Success'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            storage.setItem('token', token);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/MO/', (Route<dynamic> route) => false);
                          } else if (role == "Owner") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login Success'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            storage.setItem('token', token);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/Laporan', (Route<dynamic> route) => false);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Hanya MO yang bisa login"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      });
                      return;
                    }

                    final String email = _emailController.text;
                    final password = _passwordController.text;
                    Auth_bloc.loginCustomerFn(email, password);
                    Auth_bloc.loginCustomer.listen((event) {
                      token = event.token;
                      if (token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login Failed'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login Success'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        storage.setItem('token', token);
                        storage.setItem('namaUser', event.nama);
                        storage.setItem('emailUser', event.email);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/', (Route<dynamic> route) => false);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: COLOR.secondaryColor,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
