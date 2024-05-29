part of 'laporan_bloc_bloc.dart';

enum LaporanStatus { initial, loading, success, error }

class LaporanBahanBakuBlocState {
  final LaporanStatus status;
  final ModelLaporanStokBahanBaku laporan;

  const LaporanBahanBakuBlocState({
    this.status = LaporanStatus.initial,
    this.laporan = ModelLaporanStokBahanBaku.empty,
  });

  List<Object> get props => [status, laporan];

  LaporanBahanBakuBlocState copyWith({
    LaporanStatus? status,
    ModelLaporanStokBahanBaku? laporan,
  }) {
    return LaporanBahanBakuBlocState(
      status: status ?? this.status,
      laporan: laporan ?? this.laporan,
    );
  }
}
