import 'package:flutter/material.dart';
import 'package:untitled/models/Model_History_Saldo.dart';
import 'package:untitled/models/Model_Laporan_Keuangan.dart';
import 'package:untitled/ui/Customer_UI/IndexCustomer.dart';
import 'package:untitled/ui/FirstScreen.dart';
import 'package:untitled/ui/LoginScreen.dart';
import 'package:untitled/ui/MO_UI/Index_MO.dart';
import 'package:untitled/ui/MO_UI/Laporan/Laporan.dart';
import 'package:untitled/ui/MO_UI/Laporan/Laporan_Pemasukan_Pengeluaran/Laporan_Keuangan.dart';
import 'package:untitled/ui/RegisterScreen.dart';
import 'package:untitled/ui/IntroductionScreen.dart';
import 'package:untitled/ui/Customer_UI/Forgot_Password/ForgotPassword.dart';
import 'package:untitled/ui/Customer_UI/Forgot_Password/VerifyOTP.dart';
import 'package:untitled/ui/Customer_UI/Forgot_Password/ChangePassword.dart';
import 'package:untitled/ui/Customer_UI/Profile/RequestSaldoUI.dart';
import 'package:untitled/ui/Customer_UI/Profile/HistorySaldoUI.dart';
import 'package:untitled/ui/MO_UI/Laporan/Laporan_Pemasukan_Pengeluaran/Laporan_Keuangan.dart';

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
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/verify-otp':
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => VerifyOTPScreen(email: email),
        );
      case '/change-password':
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(email: email),
        );
      case '/request_saldo':
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RequestSaldoUI(email: email),
        );
      case '/history_saldo':
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => HistoryPenarikanSaldoUI(email: email),
        );
      case '/laporan_keuangan':
        return MaterialPageRoute(builder: (_) => LaporanKeuanganScreen());
      case '/MO/':
        return MaterialPageRoute(builder: (_) => const Index_MO());
      case '/Home':
        return MaterialPageRoute(builder: (_) => const IndexCustomer());
      case '/Laporan':
        return MaterialPageRoute(builder: (_) => const LaporanUI());
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
