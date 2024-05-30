import 'package:flutter/material.dart';
import 'package:untitled/ui/Customer_UI/History_Pembelian/HistoryUI.dart';
import 'package:untitled/ui/Customer_UI/Home/HomeUI.dart';
import 'package:untitled/ui/Customer_UI/Profile/ProfileUI.dart';
import 'package:untitled/ui/Customer_UI/Profile/SaldoUI.dart';

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
   BottomNavigationBarItem(
    icon: Icon(Icons.account_balance_wallet),
    label: 'Saldo',
  ),
];

const List<Widget> bottomNavigationBarPages = [
  HistoryUI(),
  HomeUI(),
  ProfileUI(),
  SaldoUI()
];
