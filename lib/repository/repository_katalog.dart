import "package:untitled/api_provider/katalog_provider.dart";
import "package:untitled/models/Model_Katalog.dart";

class RepositoryKatalog {
  final Katalog_Provider katalogProvider = Katalog_Provider();

  Future<List<ModelKatalog>> getProdukbyKategori(String kategori) async {
    return katalogProvider.getProdukByKategori(kategori);
  }
}
