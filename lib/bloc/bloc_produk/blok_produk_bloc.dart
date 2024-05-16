import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled/models/Model_Katalog.dart';
import 'package:untitled/repository/repository_katalog.dart';

part 'blok_produk_event.dart';
part 'blok_produk_state.dart';

class BlokProdukBloc extends Bloc<BlokProdukEvent, BlokProdukState> {
  BlokProdukBloc() : super(const BlokProdukState()) {
    on<GetProduk>(_mapGetProdukToState);
  }

  final RepositoryKatalog repositoryKatalog = RepositoryKatalog();

  void _mapGetProdukToState(
    GetProduk event,
    Emitter<BlokProdukState> emit,
  ) async {
    emit(state.copyWith(status: ProdukStatus.loading));
    try {
      final produk =
          await repositoryKatalog.getProdukbyKategori(event.kategori);
      emit(state.copyWith(status: ProdukStatus.success, produk: produk));
    } catch (e) {
      emit(state.copyWith(status: ProdukStatus.failure));
    }
  }
}
