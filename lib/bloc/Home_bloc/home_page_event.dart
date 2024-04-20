part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class TabChange extends HomePageEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
