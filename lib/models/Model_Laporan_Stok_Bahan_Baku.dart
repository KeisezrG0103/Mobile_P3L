import 'package:equatable/equatable.dart';
import 'package:untitled/models/Model_Bahan_Baku.dart';

class ModelLaporanStokBahanBaku extends Equatable {
  final String status;
  final String date;
  final List<ModelBahanBaku> data;

  const ModelLaporanStokBahanBaku({
    required this.status,
    required this.date,
    required this.data,
  });

  static const empty = ModelLaporanStokBahanBaku(
    status: '',
    date: '',
    data: [],
  );

  factory ModelLaporanStokBahanBaku.fromJson(Map<String, dynamic> json) {
    return ModelLaporanStokBahanBaku(
      status: json['status'],
      date: json['date'],
      data: (json['data'] as List)
          .map((e) => ModelBahanBaku.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object> get props => [status, date, data];
}
