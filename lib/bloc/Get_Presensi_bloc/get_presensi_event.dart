part of 'get_presensi_bloc.dart';

sealed class GetPresensiEvent extends Equatable {
  const GetPresensiEvent();

  @override
  List<Object> get props => [];
}

class GetAllPresensi extends GetPresensiEvent {
  @override
  List<Object> get props => [];
}

class ChangeToTidakHadir extends GetPresensiEvent {
  final int Id;

  ChangeToTidakHadir(this.Id);

  @override
  List<Object> get props => [Id];
}
