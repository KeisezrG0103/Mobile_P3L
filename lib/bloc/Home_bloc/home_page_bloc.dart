import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:core';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial(tabIndex: 1)) {
    on<HomePageEvent>((event, emit) {
      if (event is TabChange) {
        emit(HomePageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
