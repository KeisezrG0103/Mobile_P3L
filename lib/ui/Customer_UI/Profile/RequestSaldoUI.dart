import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/models/Model_Request_Saldo.dart';
import 'package:untitled/api_provider/saldo_provider.dart';

class RequestSaldoUI extends StatelessWidget {
  final String email;

  const RequestSaldoUI({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaldoProvider()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: _RequestSaldoForm(email: email),
        ),
      ),
    );
  }
}

class _RequestSaldoForm extends StatefulWidget {
  final String email;

  const _RequestSaldoForm({Key? key, required this.email}) : super(key: key);

  @override
  _RequestSaldoFormState createState() => _RequestSaldoFormState();
}

class _RequestSaldoFormState extends State<_RequestSaldoForm> {
  final _formKey = GlobalKey<FormState>();
  final _jumlahPenarikanController = TextEditingController();
  final _bankController = TextEditingController();
  final _nomorRekeningController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final request = SaldoRequest(
          email: widget.email,
          jumlahPenarikan: double.parse(_jumlahPenarikanController.text),
          bank: _bankController.text,
          nomorRekening: _nomorRekeningController.text,
        );

        try {
          final response = await Provider.of<SaldoProvider>(context, listen: false).requestSaldo(request);
          if (response != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Saldo request successful'),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          } 
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ));
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    }

    return Padding(
      padding: EdgeInsets.all(35.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 25),
            Text(
              'Withdraw Saldo',
              style: TextStyle(
                fontSize: 35,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Jumlah Penarikan',
              style: TextStyle(
                fontSize: 18,
                color: COLOR.Black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: _jumlahPenarikanController,
              decoration: InputDecoration(
                labelText: 'Jumlah Penarikan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Color(0xFFE7E9F0),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jumlah Penarikan Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            SizedBox(height: 25),
            Text(
              'Nama Bank',
              style: TextStyle(
                fontSize: 18,
                color: COLOR.Black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: _bankController,
              decoration: InputDecoration(
                labelText: 'Bank',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Color(0xFFE7E9F0),
              ),
             
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Bank Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            SizedBox(height: 25),
            Text(
              'Nomor Rekening',
              style: TextStyle(
                fontSize: 18,
                color: COLOR.Black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            TextFormField(
              controller: _nomorRekeningController,
              decoration: InputDecoration(
                labelText: 'Nomor Rekening',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Color(0xFFE7E9F0),
              ),
               keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor Rekening Tidak Boleh Kosong!';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'ENTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}