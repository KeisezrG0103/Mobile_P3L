import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:localstorage/localstorage.dart';
import 'package:untitled/constant/url.dart';
import 'package:untitled/models/Model_Laporan_Stok_Bahan_Baku.dart';

class LaporanProvider {
  final Client client = Client();
  final LocalStorage storage = LocalStorage('localstorage_app');

  Future<ModelLaporanStokBahanBaku> getLaporanStokBahanBaku() async {
    final token = storage.getItem('token');

    try {
      final response = await client.get(
        Uri.parse(URL.LAPORAN_STOK_BAHAN_BAKU),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        print('Response: ${response.body}');
        return ModelLaporanStokBahanBaku.empty;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Response: ${responseData}');
      return ModelLaporanStokBahanBaku.fromJson(responseData);
    } catch (e) {
      return ModelLaporanStokBahanBaku.empty;
    }
  }
}
