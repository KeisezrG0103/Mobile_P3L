import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/Model_History_Saldo.dart';
import 'package:untitled/api_provider/saldo_provider.dart';
import 'package:untitled/constant/color.dart';

class HistoryPenarikanSaldoUI extends StatelessWidget {
  final String email;

  const HistoryPenarikanSaldoUI({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaldoProvider()),
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                'Saldo Withdrawal History',
                style: TextStyle(
                  fontSize: 35,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _HistoryList(email: email),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryList extends StatelessWidget {
  final String email;

  const _HistoryList({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<SaldoProvider>(context);
    return FutureBuilder<List<HistoryPenarikanSaldo>>(
      future: historyProvider.getHistoryPenarikanSaldo(email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load history'),
          );
        } else {
          final history = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: List.generate(history.length, (index) {
                final item = history[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Warna Tanggal Penarikan
                            ),
                            children: [
                              TextSpan(
                                text: 'Tanggal Penarikan : ',
                              ),
                              TextSpan(
                                text: item.tanggalPenarikan,
                                style: TextStyle(fontWeight: FontWeight.normal), // Jangan bold
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Jumlah  :  Rp. ${item.jumlahPenarikan}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Status : ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _buildStatusBadge(item.status),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }
      },
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor = status == 'Berhasil' ? Colors.green : COLOR.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}