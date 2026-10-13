import 'package:flutter/material.dart';

// definisi variabel konstan untuk menyimpan komposisi palet warna bertemakan perangkat aktivitas luar ruangan (outdoor)
const Color kForest = Color(0xFF1B3A2F);
const Color kOrange = Color(0xFFE8833A);
const Color kCream = Color(0xFFF4EFE6);

// class cetak biru yang memodelkan informasi properti struktur dari setiap entitas sewaan
class Product {
  final String name;
  final String description;
  final String imgPath;
  final int price;
  int stock;
  int qty;

  // pendefinisian konstruktor objek yang mewajibkan implementasi argumen terdaftar (required keyword)
  Product({
    required this.name,
    required this.description,
    required this.imgPath,
    required this.price,
    required this.stock,
    this.qty = 0,
  });
}

// utilitas algoritma kecil yang bertugas mengonversi tipe integer biasa menjadi konvensi pemformatan nilai nominal harga rupiah
String formatRupiah(int value) {
  final text = value.toString();
  String result = '';
  for (int i = 0; i < text.length; i++) {
    if (i > 0 && (text.length - i) % 3 == 0) result += '.';
    result += text[i];
  }
  return 'Rp $result';
}