import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:untitled/constant/url.dart';
import 'package:untitled/models/Model_Katalog.dart';

class Katalog_Provider {
  final Client client = Client();

  Future<List<ModelKatalog>> getProdukByKategori(String kategori) async {
    try {
      final response = await client.get(
        Uri.parse('${URL.GetProdukByRequest}/$kategori'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept-Encoding': 'gzip, deflate, br',
          "Connection": "Keep-Alive",
        },
      );

      if (response.statusCode != 200) {
        print('Response: ${response.body}');
        return <ModelKatalog>[];
      }

      try {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> katalogList = responseData['data'];

        final listKatalog =
            katalogList.map((e) => ModelKatalog.fromJson(e)).toList();

        print('Parsed listKatalog: $listKatalog');

        return listKatalog;
      } catch (e) {
        print('Error parsing JSON: $e');
        return <ModelKatalog>[];
      }
    } catch (e) {
      return <ModelKatalog>[];
    }
  }
}
