part of 'kategori_bloc.dart';

class KategoriState extends Equatable {
  final KategoriStatus kategori;

  const KategoriState({
    this.kategori = KategoriStatus.cake,
  });

  @override
  List<Object> get props => [kategori];

  KategoriState copyWith({
    KategoriStatus? kategori,
  }) {
    return KategoriState(
      kategori: kategori ?? this.kategori,
    );
  }
}
