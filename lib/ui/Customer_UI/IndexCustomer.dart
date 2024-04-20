import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/Home_bloc/home_page_bloc.dart';
import 'package:untitled/ui/Customer_UI/BottomNavbar.dart';

class IndexCustomer extends StatelessWidget {
  const IndexCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
        ),
      ],
      child: const BottomNavbar(),
    );
  }
}
