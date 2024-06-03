import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:untitled/api_provider/laporan_provider.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/models/Model_Laporan_Keuangan.dart';
import 'package:intl/intl.dart';

class LaporanKeuanganScreen extends StatefulWidget {
  @override
  _LaporanKeuanganScreenState createState() => _LaporanKeuanganScreenState();
}

class _LaporanKeuanganScreenState extends State<LaporanKeuanganScreen> {
  late DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LaporanProvider>(create: (_) => LaporanProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Laporan Keuangan'),
          backgroundColor: COLOR.primaryColor,
          actions: [
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () => _downloadPdf(context),
            ),
          ],
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Pilih Tanggal',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 100.0,
                  horizontal: 10.0), // Mengurangi padding di sekitar tabel
              child: FutureBuilder<LaporanKeuangan>(
                future: Provider.of<LaporanProvider>(context, listen: false)
                    .getLaporanKeuangan(_selectedDate.toString()),
                builder: (context, AsyncSnapshot<LaporanKeuangan> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final laporan = snapshot.data!;
                    return Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                      },
                      children: _buildTableRows(laporan),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TableRow> _buildTableRows(LaporanKeuangan laporan) {
    double totalPemasukan = (laporan.totalPenjualan ?? 0).toDouble() +
        (laporan.totalTip ?? 0).toDouble();
    double totalPengeluaran = laporan.pengeluaranLain
            .fold(0.0, (sum, item) => sum + (item.harga ?? 0).toDouble()) +
        (laporan.totalPengadaanBahanBaku ?? 0).toDouble() +
        (laporan.totalGajiKaryawan ?? 0).toDouble() +
        (laporan.totalPembayaranPenitip ?? 0.0);

    String formattedTotalPemasukan = formatPemasukan(totalPemasukan);
    String formattedTotalPengeluaran = formatPengeluaran(totalPengeluaran);

    return [
      TableRow(
        decoration: BoxDecoration(color: COLOR.primaryColor),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Pemasukan',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Pengeluaran',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Penjualan'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${formatPemasukan(laporan.totalPenjualan ?? 0)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('-'),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Tip'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${formatPemasukan(laporan.totalTip ?? 0)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('-'),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Bahan Baku'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('-'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '${formatPengeluaran(laporan.totalPengadaanBahanBaku ?? 0)}'),
          ),
        ],
      ),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Gaji Karyawan'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('-'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${formatPengeluaran(laporan.totalGajiKaryawan ?? 0)}'),
          ),
        ],
      ),
      ...laporan.pengeluaranLain.map((pengeluaran) => TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(pengeluaran.namaPengeluaran),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('-'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${formatPengeluaran(pengeluaran.harga ?? 0)}'),
              ),
            ],
          )),
      TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Pembayaran ke Penitip'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('-'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '${formatPengeluaran(laporan.totalPembayaranPenitip ?? 0)}'),
          ),
        ],
      ),
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[300]),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$formattedTotalPemasukan',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$formattedTotalPengeluaran',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _downloadPdf(BuildContext context) async {
    final laporanProvider =
        Provider.of<LaporanProvider>(context, listen: false);
    final laporan =
        await laporanProvider.getLaporanKeuangan(_selectedDate.toString());
    final pdf = pw.Document();

    double totalPemasukan = (laporan.totalPenjualan ?? 0).toDouble() +
        (laporan.totalTip ?? 0).toDouble();
    double totalPengeluaran = laporan.pengeluaranLain
            .fold(0.0, (sum, item) => sum + (item.harga ?? 0).toDouble()) +
        (laporan.totalPengadaanBahanBaku ?? 0).toDouble() +
        (laporan.totalGajiKaryawan ?? 0).toDouble() +
        (laporan.totalPembayaranPenitip ?? 0.0);

    String formattedTotalPemasukan = formatPemasukan(totalPemasukan);
    String formattedTotalPengeluaran = formatPengeluaran(totalPengeluaran);

    final selectedDate = _selectedDate;
    final tanggalCetak =
        DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.now());
    final bulan = DateFormat('MM', 'id_ID').format(selectedDate);
    final tahun = DateFormat('yyyy', 'id_ID').format(selectedDate);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Laporan Pemasukan dan Pengeluaran',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Bulan: $bulan, Tahun: $tahun'),
              pw.SizedBox(height: 20),
              pw.Text('Tanggal Cetak: $tanggalCetak'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Item', 'Pemasukan', 'Pengeluaran'],
                  [
                    'Total Penjualan',
                    '${formatPemasukan(laporan.totalPenjualan ?? 0)}',
                    '-'
                  ],
                  [
                    'Total Tip',
                    '${formatPemasukan(laporan.totalTip ?? 0)}',
                    '-'
                  ],
                  ...laporan.pengeluaranLain.map(
                    (e) => [
                      e.namaPengeluaran,
                      '-',
                      '${formatPengeluaran(e.harga ?? 0)}'
                    ],
                  ),
                  [
                    'Total Pengadaan Bahan Baku',
                    '-',
                    '${formatPemasukan(laporan.totalPengadaanBahanBaku) ?? 0}'
                  ],
                  [
                    'Total Pembayaran Penitip',
                    '-',
                    '${formatPemasukan(laporan.totalPembayaranPenitip) ?? 0.0}'
                  ],
                  [
                    'Total Gaji Karyawan',
                    '-',
                    '${formatPemasukan(laporan.totalGajiKaryawan) ?? 0}'
                  ],
                  [
                    'Total',
                    '$formattedTotalPemasukan',
                    '$formattedTotalPengeluaran'
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Laporan_Keuangan.pdf');
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }

  String formatPemasukan(num value) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
    return formatCurrency.format(value.toDouble());
  }

  String formatPengeluaran(num value) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
    return formatCurrency.format(value.toDouble());
  }
}
