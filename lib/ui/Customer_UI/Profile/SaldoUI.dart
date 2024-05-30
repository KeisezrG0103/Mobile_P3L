import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/api_provider/saldo_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/ui/Customer_UI/Profile/RequestSaldoUI.dart';

class SaldoUI extends StatefulWidget {
  const SaldoUI({Key? key}) : super(key: key);

  @override
  _SaldoUIState createState() => _SaldoUIState();
}

class _SaldoUIState extends State<SaldoUI> {
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final LocalStorage storage = LocalStorage('localstorage_app');
    await storage.ready;
    setState(() {
      email = storage.getItem('emailUser') as String? ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SaldoProvider()),
        ],
        child: Center(
          child: Consumer<SaldoProvider>(
            builder: (context, saldoProvider, _) {
              return FutureBuilder<double>(
                future: saldoProvider.getTotalSaldo(email),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    double totalSaldo = snapshot.data!;

                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 45),
                            Text(
                              'Saldo',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Total Saldo:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Rp. $totalSaldo',
                                      style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 45),
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/request_saldo',
                                    arguments: email,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Withdraw Saldo',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: COLOR.Black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: COLOR.Black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 35),
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                    Navigator.pushNamed(
                                    context,
                                    '/history_saldo',
                                    arguments: email,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Saldo Withdrawal History',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: COLOR.Black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: COLOR.Black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}