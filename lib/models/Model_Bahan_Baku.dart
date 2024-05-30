import 'package:equatable/equatable.dart';

class ModelBahanBaku extends Equatable {
  final int id;
  final String nama;
  final int qty;
  final String satuan;

  ModelBahanBaku({
    required this.id,
    required this.nama,
    required this.qty,
    required this.satuan,
  });

  factory ModelBahanBaku.fromJson(Map<String, dynamic> json) {
    return ModelBahanBaku(
      id: json['Id'],
      nama: json['Nama'],
      qty: json['Qty'],
      satuan: json['Satuan'],
    );
  }

  @override
  List<Object> get props => [id, nama, qty, satuan];
}
