import 'package:equatable/equatable.dart';

class Presensi extends Equatable {
  final int Id;
  final String Tanggal;
  final String Nama_Karyawan;
  final String Status;
  final int Karyawan_Id;

  Presensi({
    required this.Id,
    required this.Tanggal,
    required this.Nama_Karyawan,
    required this.Status,
    required this.Karyawan_Id,
  });

  factory Presensi.empty() {
    return Presensi(
      Id: 0,
      Tanggal: '',
      Nama_Karyawan: '',
      Status: '',
      Karyawan_Id: 0,
    );
  }

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      Id: json['Id'],
      Tanggal: json['Tanggal'],
      Nama_Karyawan: json['Nama_Karyawan'],
      Status: json['Status'],
      Karyawan_Id: json['Karyawan_Id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'Tanggal': Tanggal,
        'Nama_Karyawan': Nama_Karyawan,
        'Status': Status,
        'Karyawan_Id': Karyawan_Id,
      };

  @override
  List<Object> get props => [Id, Tanggal, Nama_Karyawan, Status, Karyawan_Id];
}
