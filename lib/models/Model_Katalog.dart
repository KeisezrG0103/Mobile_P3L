import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ModelKatalog extends Equatable {
  final int id;
  final String nama;
  final int harga;
  final String gambar;
  final String kategori;
  final int kuota;
  final int stok;

  const ModelKatalog({
    required this.id,
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.kategori,
    required int? kuota,
    required this.stok,
  }) : kuota = kuota ?? 0;

  factory ModelKatalog.fromJson(Map<String, dynamic> json) {
    return ModelKatalog(
      id: json['Id'],
      nama: json['Nama'],
      harga: json['Harga'],
      gambar: json['Gambar'],
      kategori: json['Nama_Kategori'],
      kuota: json['Kuota'],
      stok: json['Stok'],
    );
  }

  @override
  List<Object> get props => [id, nama, harga, gambar, kategori, kuota, stok];
}
