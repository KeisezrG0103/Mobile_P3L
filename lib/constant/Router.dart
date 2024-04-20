import 'package:flutter/material.dart';
import 'package:untitled/ui/Customer_UI/IndexCustomer.dart';
import 'package:untitled/ui/FirstScreen.dart';
import 'package:untitled/ui/LoginScreen.dart';
import 'package:untitled/ui/MO_UI/Index_MO.dart';
import 'package:untitled/ui/RegisterScreen.dart';
import 'package:untitled/ui/IntroductionScreen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/IntroductionScreen':
        return MaterialPageRoute(builder: (_) => const IntroductionScreen());
      case '/FirstScreen':
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case '/':
        return MaterialPageRoute(builder: (_) => const IndexCustomer());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case '/MO/':
        return MaterialPageRoute(builder: (_) => const Index_MO());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No constant defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
