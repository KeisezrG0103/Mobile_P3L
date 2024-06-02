class LaporanKeuangan {
  final int totalPenjualan;
  final int totalTip;
  final List<Pengeluaran> pengeluaranLain;
  final int totalPengadaanBahanBaku;
  final double totalPembayaranPenitip;
  final int totalGajiKaryawan;

  LaporanKeuangan({
    required this.totalPenjualan,
    required this.totalTip,
    required this.pengeluaranLain,
    required this.totalPengadaanBahanBaku,
    required this.totalPembayaranPenitip,
    required this.totalGajiKaryawan,
  });

  factory LaporanKeuangan.fromJson(Map<String, dynamic> json) {
    return LaporanKeuangan(
      totalPenjualan: (json['data']['penjualan']['TotalPenjualan'] ?? 0) as int,
      totalTip: (json['data']['penjualan']['TotalTip'] ?? 0) as int,
      pengeluaranLain: List<Pengeluaran>.from(json['data']['pengeluaranLain']
          .map((pengeluaran) => Pengeluaran.fromJson(pengeluaran))),
      totalPengadaanBahanBaku: (json['data']['totalPengadaanBahanBaku']['TotalPengadaanBahanBaku'] ?? 0) as int,
      totalPembayaranPenitip: (json['data']['totalPembayaranPenitip']['TotalPembayaranPenitip'] ?? 0.0).toDouble(),
      totalGajiKaryawan: (json['data']['totalGajiKaryawan']['TotalGajiKaryawan'] ?? 0) as int,
    );
  }
}

class Pengeluaran {
  final String namaPengeluaran;
  final int harga;

  Pengeluaran({
    required this.namaPengeluaran,
    required this.harga,
  });

  factory Pengeluaran.fromJson(Map<String, dynamic> json) {
    return Pengeluaran(
      namaPengeluaran: json['Nama_Pengeluaran'] ?? '',
      harga: (json['Harga'] ?? 0) as int,
    );
  }
}