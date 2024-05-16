part of '../bloc_produk/blok_produk_bloc.dart';

enum ProdukStatus { initial, loading, success, failure }

class BlokProdukState extends Equatable {
  final List<ModelKatalog> produk;
  final ProdukStatus status;

  const BlokProdukState({
    this.produk = const <ModelKatalog>[],
    this.status = ProdukStatus.initial,
  });

  @override
  List<Object> get props => [produk, status];

  BlokProdukState copyWith({
    List<ModelKatalog>? produk,
    ProdukStatus? status,
  }) {
    return BlokProdukState(
      produk: produk ?? this.produk,
      status: status ?? this.status,
    );
  }
}
