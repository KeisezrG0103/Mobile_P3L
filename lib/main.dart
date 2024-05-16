import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/constant/Router.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:untitled/bloc/Home_bloc/home_page_bloc.dart';
import 'package:untitled/constant/color.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'AppState.dart';

late final ValueNotifier<String> token;
late final ValueNotifier<String> namaUser;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final LocalStorage storage = LocalStorage('localstorage_app');
  await storage.ready;
  storage.clear();
  token = ValueNotifier<String>(storage.getItem('token') as String? ?? '');
  namaUser =
      ValueNotifier<String>(storage.getItem('namaUser') as String? ?? '');

  String initialRoute = (token.value.isNotEmpty && namaUser.value.isNotEmpty)
      ? '/Home'
      : '/IntroductionScreen';

  runApp(MyApp(initialRoute: initialRoute));

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: COLOR.primaryColor,
      ),
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: initialRoute,
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
