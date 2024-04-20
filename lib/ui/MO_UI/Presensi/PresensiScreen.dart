import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/Get_Presensi_bloc/get_presensi_bloc.dart';
import 'package:untitled/repository/repository_presensi.dart';
import 'package:untitled/ui/MO_UI/Presensi/MO_PresensiScreen.dart';

class PresensiScreen extends StatelessWidget {
  const PresensiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RepositoryPresensi(),
      child: BlocBuilder<GetPresensiBloc, GetPresensiState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isSuccess) {
            final presensi = state.presensi;
            print(presensi);
            return PresensiSuccess(presensi: presensi!);
          } else if (state.status.isError) {
            return Center(
              child: Text('error'),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
