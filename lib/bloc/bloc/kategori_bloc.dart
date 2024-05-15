import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'kategori_event.dart';
part 'kategori_state.dart';

enum KategoriStatus { cake, drink, penitip, bread }

class KategoriBloc extends Bloc<KategoriEvent, KategoriState> {
  KategoriBloc() : super(const KategoriState()) {
    on<changeKategori>(_mapChangeKategoriToState);
  }

  void _mapChangeKategoriToState(
    changeKategori event,
    Emitter<KategoriState> emit,
  ) async {
    emit(state.copyWith(kategori: event.getKategori));
  }
}
