class HistoryPenarikanSaldo {
  final int jumlahPenarikan;
  final String customerEmail;
  final String tanggalPenarikan;
  final String status;

  HistoryPenarikanSaldo({
    required this.jumlahPenarikan,
    required this.customerEmail,
    required this.tanggalPenarikan,
    required this.status,
  });

  factory HistoryPenarikanSaldo.fromJson(Map<String, dynamic> json) {
    return HistoryPenarikanSaldo(
      jumlahPenarikan: json['Jumlah_Penarikan'],
      customerEmail: json['Customer_Email'],
      tanggalPenarikan: json['Tanggal_Penarikan'],
      status: json['Status'],
    );
  }
}