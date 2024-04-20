import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/models/Model_Presensi.dart';
import 'package:untitled/repository/repository_presensi.dart';
part 'get_presensi_event.dart';
part 'get_presensi_state.dart';

class GetPresensiBloc extends Bloc<GetPresensiEvent, GetPresensiState> {
  GetPresensiBloc({
    required this.presensiRepository,
  }) : super(const GetPresensiState()) {
    on<GetAllPresensi>(_mapGetAllPresensiToState);
  }

  final RepositoryPresensi presensiRepository;

  void _mapGetAllPresensiToState(
    GetAllPresensi event,
    Emitter<GetPresensiState> emit,
  ) async {
    emit(state.copyWith(status: PresensiStatus.loading));
    try {
      final presensi = await presensiRepository.getAllPresensi();
      emit(state.copyWith(status: PresensiStatus.success, presensi: presensi));
    } catch (e) {
      emit(state.copyWith(status: PresensiStatus.error));
    }
  }
}
