import 'package:flutter/material.dart';
import 'package:untitled/ui/Customer_UI/Home/HomeUI.dart';
import 'package:untitled/ui/MO_UI/Presensi/Index_Presensi.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems =
    const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.insert_chart_outlined),
    label: 'Laporan',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Presensi',
  ),
];

const List<Widget> bottomNavigationBarPages = [
  Text('Laporan'),
  HomeUI(),
  IndexPresensi(),
];
