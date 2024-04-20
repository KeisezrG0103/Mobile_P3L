import 'package:flutter/material.dart';
import 'package:untitled/ui/Customer_UI/History_Pembelian/HistoryUI.dart';
import 'package:untitled/ui/Customer_UI/Home/HomeUI.dart';
import 'package:untitled/ui/Customer_UI/Profile/ProfileUI.dart';

List<BottomNavigationBarItem> bottomNavigationBarItems =
    const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.insert_chart_outlined),
    label: 'History Pembelian',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];

const List<Widget> bottomNavigationBarPages = [
  HistoryUI(),
  HomeUI(),
  ProfileUI(),
];
