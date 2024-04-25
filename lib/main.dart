import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/constant/Router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:untitled/bloc/Home_bloc/home_page_bloc.dart'; // Import your HomePageBloc
import 'package:untitled/constant/color.dart';

import 'AppState.dart';

late final ValueNotifier<String> token;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalStorage storage = LocalStorage('localstorage_app');
  await storage.ready;
  token = ValueNotifier<String>(storage.getItem('token') as String? ?? '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: COLOR.primaryColor,
      ),
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: '/IntroductionScreen',
      navigatorKey: NavigationService.instance.navigatorKey,
      builder: (context, child) {
        return Provider.value(
          value: NavigationService.instance,
          child: child!,
        );
      },
    );
  }
}
