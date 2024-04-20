import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/Home_bloc/home_page_bloc.dart';
import 'package:untitled/ui/MO_UI/MO_layout.dart';
import 'package:untitled/bloc/Get_Presensi_bloc/get_presensi_bloc.dart';
import 'package:untitled/repository/repository_presensi.dart';

class Index_MO extends StatelessWidget {
  const Index_MO({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HomePageBloc>(
            create: (context) => HomePageBloc(),
          ),
        ],
        child: MO_layout(),
      ),
    );
  }
}
