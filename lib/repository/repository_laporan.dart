import 'package:untitled/api_provider/laporan_provider.dart';
import 'package:untitled/models/Model_Bahan_Baku.dart';
import 'package:untitled/models/Model_Laporan_Stok_Bahan_Baku.dart';

class RepositoryLaporan {
  final LaporanProvider laporanProvider = LaporanProvider();

  Future<ModelLaporanStokBahanBaku> getLaporanStokBahanBaku() async {
    return laporanProvider.getLaporanStokBahanBaku();
  }
}
