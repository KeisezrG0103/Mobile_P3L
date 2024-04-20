import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:untitled/bloc/Home_bloc/home_page_bloc.dart';
import 'package:untitled/constant/HomeConstant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/constant/color.dart';
import 'package:untitled/constant/HexColor.dart';

class MO_layout extends StatelessWidget {
  const MO_layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:
              Center(child: bottomNavigationBarPages.elementAt(state.tabIndex)),
          bottomNavigationBar: BottomNavigationBar(
              items: bottomNavigationBarItems,
              currentIndex: state.tabIndex,
              selectedItemColor: COLOR.primaryColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                BlocProvider.of<HomePageBloc>(context)
                    .add(TabChange(tabIndex: index));
              }),
        );
      },
    );
  }
}
