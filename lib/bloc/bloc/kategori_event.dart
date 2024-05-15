part of 'kategori_bloc.dart';

sealed class KategoriEvent extends Equatable {
  const KategoriEvent();

  @override
  List<Object> get props => [];
}

class changeKategori extends KategoriEvent {
  final KategoriStatus kategori;

  changeKategori(this.kategori);

  @override
  List<Object> get props => [kategori];

  get getKategori => kategori;
}
