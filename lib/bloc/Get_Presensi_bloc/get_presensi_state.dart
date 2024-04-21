part of 'get_presensi_bloc.dart';

enum PresensiStatus { initial, loading, success, error }

extension PresensiStatusX on PresensiStatus {
  bool get isInitial => this == PresensiStatus.initial;
  bool get isLoading => this == PresensiStatus.loading;
  bool get isSuccess => this == PresensiStatus.success;
  bool get isError => this == PresensiStatus.error;
}

class GetPresensiState extends Equatable {
  final PresensiStatus status;
  final List<Presensi> presensi;

  const GetPresensiState({
    this.status = PresensiStatus.initial,
    this.presensi = const <Presensi>[],
  });

  @override
  List<Object> get props => [status, presensi];

  GetPresensiState copyWith({
    PresensiStatus? status,
    List<Presensi>? presensi,
  }) {
    return GetPresensiState(
      status: status ?? this.status,
      presensi: presensi ?? this.presensi,
    );
  }
}

class ChangeToTidakHadirState extends Equatable {
  final PresensiStatus status;
  final int Id;

  const ChangeToTidakHadirState({
    required this.Id,
    this.status = PresensiStatus.initial,
  });

  @override
  List<Object> get props => [status, Id];

  ChangeToTidakHadirState copyWith({
    PresensiStatus? status,
    int? Id,
  }) {
    return ChangeToTidakHadirState(
      status: status ?? this.status,
      Id: Id ?? this.Id,
    );
  }
}
