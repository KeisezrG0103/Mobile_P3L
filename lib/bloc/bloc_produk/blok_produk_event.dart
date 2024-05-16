part of '../bloc_produk/blok_produk_bloc.dart';

sealed class BlokProdukEvent extends Equatable {
  const BlokProdukEvent();

  @override
  List<Object> get props => [];
}

class GetProduk extends BlokProdukEvent {
  final String kategori;

  GetProduk(this.kategori);

  @override
  List<Object> get props => [kategori];
}
