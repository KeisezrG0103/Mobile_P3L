import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/constant/url.dart';
import 'package:untitled/models/Model_Request_Saldo.dart';
import 'package:untitled/models/Model_History_Saldo.dart';

class SaldoProvider extends ChangeNotifier {

    Future<double> getTotalSaldo(String email) async {
    try {
      final response = await http.get(Uri.parse('${URL.SALDO}/$email'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
          if (data is List && data.isNotEmpty) {
            final saldo = data[0]['Total_Saldo'];
            if (saldo != null) {
              return double.parse(saldo.toString());
            } else {
              throw Exception('Total saldo is null');
            }
          } else {
            throw Exception('Invalid response format');
          }
      } else {
        final errorMessage = json.decode(response.body)['error']; 
        throw Exception(errorMessage != null ? errorMessage : 'Failed to load total saldo');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to connect to server');
    }

    
  }


 Future<SaldoResponse?> requestSaldo(SaldoRequest request) async {
    final url = '${URL.REQUEST}/${request.email}';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return SaldoResponse.fromJson(responseData);
      } else {
         final Map<String, dynamic> responseData = jsonDecode(response.body);
          final errorMessage = responseData['message'] as String;
          throw Exception(errorMessage);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<HistoryPenarikanSaldo>> getHistoryPenarikanSaldo(String email) async {
    final url = '${URL.HISTORY}/${email}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<HistoryPenarikanSaldo> history = data
            .map((json) => HistoryPenarikanSaldo.fromJson(json))
            .toList();
        return history;
      } else {
        throw Exception('Failed to load history');
      }
    } catch (error) {
      print('Error fetching history: $error');
      throw error;
    }
  }

}