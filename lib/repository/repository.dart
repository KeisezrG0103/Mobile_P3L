import 'package:untitled/api_provider/auth_provider.dart';

class repository {
  final AuthProvider authProvider = AuthProvider();

  Future loginKaryawan(String Nama, String Password) async {
    return authProvider.loginKaryawan(Nama, Password);
  }

  Future loginCustomer(String Email, String Password) async {
    return authProvider.loginCustomer(Email, Password);
  }

}