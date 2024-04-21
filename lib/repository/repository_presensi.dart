import 'package:untitled/api_provider/presensi_provider.dart';
import 'package:untitled/models/Model_Presensi.dart';

class RepositoryPresensi {
  final PresensiProvider presensiProvider = PresensiProvider();

  Future<List<Presensi>> getAllPresensi() async {
    return presensiProvider.getPresensi();
  }

  Future<Presensi> changeToTidakHadir(int Id) async {
    return presensiProvider.changeToTidakHadir(Id);
  }
}
