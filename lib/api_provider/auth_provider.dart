import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:untitled/models/Model_Customer_Login.dart';
import 'package:untitled/models/Model_Karyawan_Login.dart';
import 'package:untitled/constant/url.dart';

class AuthProvider {
  Client client = Client();

  Future<KaryawanLogin> loginKaryawan(String Nama, String Password) async {
    final response = await client.post(
      Uri.parse(URL.LOGIN),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Nama': Nama,
        'Password': Password,
      }),
    );
    if (response.statusCode != 200) {
      return KaryawanLogin.empty();
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    final Map<String, dynamic> data = responseData['data'];

    print(data);
    return KaryawanLogin.fromJson(data);
  }

  Future<CustomerLogin> loginCustomer(String Email, String Password) async {
    final response = await client.post(
      Uri.parse(URL.LOGIN),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': Email,
        'Password': Password,
      }),
    );

    // if (response.statusCode == 200) {
    //   return CustomerLogin.fromJson(json.decode(response.body));
    // } else {
    //   throw Exception('Failed to load data');
    // }

    if (response.statusCode != 200) {
      return CustomerLogin.empty();
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    final Map<String, dynamic> data = responseData['data'];

    //how to get give data != null but not useing null
    return CustomerLogin.fromJson(data);
  }
}
