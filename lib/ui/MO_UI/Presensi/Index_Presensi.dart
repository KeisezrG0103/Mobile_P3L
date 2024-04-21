import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/Get_Presensi_bloc/get_presensi_bloc.dart';
// import 'package:untitled/ui/MO_UI/Presensi/MO_PresensiScreen.dart';
import 'package:untitled/ui/MO_UI/Presensi/PresensiScreen.dart';
import 'package:untitled/repository/repository_presensi.dart';

class IndexPresensi extends StatelessWidget {
  const IndexPresensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider<GetPresensiBloc>(
          create: (context) => GetPresensiBloc(
            presensiRepository: RepositoryPresensi(),
          )..add(GetAllPresensi()),
        ),
        BlocProvider<ChangeToTidakHadirBloc>(
          create: (context) => ChangeToTidakHadirBloc(
            presensiRepository: RepositoryPresensi(),
          ),
        ),
      ],
      child: PresensiScreen(),
    ));
  }
}
