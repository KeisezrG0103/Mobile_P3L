class SaldoRequest {
  final String email;
  final double jumlahPenarikan;
  final String bank;
  final String nomorRekening;

  SaldoRequest({
    required this.email,
    required this.jumlahPenarikan,
    required this.bank,
    required this.nomorRekening,
  });

  Map<String, dynamic> toJson() {
    return {
      'Jumlah_Penarikan': jumlahPenarikan,
      'Bank': bank,
      'Nomor_Rekening': nomorRekening,
    };
  }
}

class SaldoResponse {
  final dynamic customer;
  final dynamic history;

  SaldoResponse({
    required this.customer,
    required this.history,
  });

  factory SaldoResponse.fromJson(Map<String, dynamic> json) {
    return SaldoResponse(
      customer: json['customer'],
      history: json['history'],
    );
  }
}
