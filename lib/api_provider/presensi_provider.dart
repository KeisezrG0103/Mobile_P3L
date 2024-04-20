import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:untitled/constant/url.dart';
import 'package:untitled/models/Model_Presensi.dart';
import 'package:localstorage/localstorage.dart';

class PresensiProvider {
  final Client client = Client();
  final LocalStorage storage = LocalStorage('localstorage_app');

  Future<List<Presensi>> getPresensi() async {
    final token = storage.getItem('token');

    try {
      final response = await client.get(
        Uri.parse(URL.PRESENSI),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        print('Response: ${response.body}');
        return <Presensi>[];
      }
      // print('Response: ${response.body}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> presensiList = responseData['data'];
      print(presensiList.map((e) => Presensi.fromJson(e)).toList());

      return presensiList.map((e) => Presensi.fromJson(e)).toList();
    } catch (e) {
      return <Presensi>[];
    }
  }
}
