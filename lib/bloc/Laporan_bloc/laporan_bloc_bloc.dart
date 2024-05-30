import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/models/Model_Laporan_Stok_Bahan_Baku.dart';
import 'package:untitled/repository/repository_laporan.dart';

part 'laporan_bloc_event.dart';
part 'laporan_bloc_state.dart';

class LaporanBlocBloc
    extends Bloc<LaporanBlocEvent, LaporanBahanBakuBlocState> {
  LaporanBlocBloc({
    required this.laporanRepository,
  }) : super(const LaporanBahanBakuBlocState()) {
    on<getLaporanStokBahanBaku>(_mapGetLaporanStokBahanBakuToState);
  }

  final RepositoryLaporan laporanRepository;

  void _mapGetLaporanStokBahanBakuToState(
    getLaporanStokBahanBaku event,
    Emitter<LaporanBahanBakuBlocState> emit,
  ) async {
    emit(state.copyWith(status: LaporanStatus.loading));
    try {
      final laporanStokBahanBaku =
          await laporanRepository.getLaporanStokBahanBaku();
      emit(state.copyWith(
          status: LaporanStatus.success, laporan: laporanStokBahanBaku));
    } catch (e) {
      emit(state.copyWith(status: LaporanStatus.error));
    }
  }
}
