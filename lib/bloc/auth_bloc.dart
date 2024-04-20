import 'dart:async';
import 'package:untitled/repository/repository.dart';
import 'package:untitled/models/Model_Karyawan_Login.dart';
import 'package:untitled/models/Model_Customer_Login.dart';

class AuthBloc {
  final _repository = repository();
  final _loginKaryawanController = StreamController<KaryawanLogin>.broadcast();
  final _loginCustomerController = StreamController<CustomerLogin>.broadcast();

  Stream<KaryawanLogin> get loginKaryawan => _loginKaryawanController.stream;

  Stream<CustomerLogin> get loginCustomer => _loginCustomerController.stream;

  loginKaryawanFn(String Nama, String Password) async {
    KaryawanLogin karyawanLogin =
        await _repository.loginKaryawan(Nama, Password);
    _loginKaryawanController.sink.add(karyawanLogin);
  }

  loginCustomerFn(String Email, String Password) async {
    CustomerLogin customerLogin =
        await _repository.loginCustomer(Email, Password);
    _loginCustomerController.sink.add(customerLogin);

  }

  dispose() {
    _loginKaryawanController.close();
    _loginCustomerController.close();
  }
}

final Auth_bloc = AuthBloc();

