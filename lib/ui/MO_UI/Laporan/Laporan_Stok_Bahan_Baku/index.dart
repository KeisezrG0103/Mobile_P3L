import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart'; // Import open_file package
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:untitled/bloc/Laporan_bloc/laporan_bloc_bloc.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/models/Model_Bahan_Baku.dart';
import 'package:untitled/models/Model_Laporan_Stok_Bahan_Baku.dart';
import 'package:untitled/repository/repository_laporan.dart';

class Index_Laporan_Bahan_Baku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaporanBlocBloc(
        laporanRepository: RepositoryLaporan(),
      )..add(getLaporanStokBahanBaku()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Laporan Stok Bahan Baku',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: COLOR.primaryColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          actions: [
            BlocBuilder<LaporanBlocBloc, LaporanBahanBakuBlocState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () => _downloadPdf(context, state.laporan.data),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<LaporanBlocBloc, LaporanBahanBakuBlocState>(
          builder: (context, state) {
            if (state.status == LaporanStatus.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == LaporanStatus.success) {
              return _buildDataTable(context, state.laporan);
            } else {
              return Center(child: Text('Data tidak tersedia'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataTable(
      BuildContext context, ModelLaporanStokBahanBaku laporan) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Nama')),
          DataColumn(label: Text('Qty')),
          DataColumn(label: Text('Satuan')),
        ],
        rows: laporan.data
            .map((data) => DataRow(
                  cells: [
                    DataCell(Text(data.id.toString())),
                    DataCell(Text(data.nama)),
                    DataCell(Text(data.qty.toString())),
                    DataCell(Text(data.satuan)),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Future<void> _downloadPdf(
      BuildContext context, List<ModelBahanBaku> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      // add tanggal cetak hari ini
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Tanggal Cetak: ${DateTime.now().toString()}',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      pw.Text(
                        'ID',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Nama',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Qty',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'Satuan',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  ...data.map(
                    (e) => pw.TableRow(
                      children: [
                        pw.Text(e.id.toString()),
                        pw.Text(e.nama),
                        pw.Text(e.qty.toString()),
                        pw.Text(e.satuan),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/Laporan-stok-bahanBaku.pdf');
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(file.path);
  }
}
