import 'package:flutter/material.dart';

// palet warna utama yang digunakan pada keseluruhan aplikasi
const Color kForest = Color(0xFF1B3A2F);
const Color kOrange = Color(0xFFE8833A);
const Color kCream = Color(0xFFF4EFE6);

// class product sebagai blueprint untuk membuat objek barang sewaan
class Product {
  final String id;
  final String name;
  final String description;
  final String imgPath;
  final String category; // atribut baru untuk mengelompokkan jenis barang
  final int price;
  int stock;

  // constructor wajib diisi semua nilai saat objek dibuat
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imgPath,
    required this.category,
    required this.price,
    required this.stock,
  });
}

// fungsi manipulasi string untuk memformat angka nominal ke bentuk rupiah
String formatRupiah(int value) {
  String text = value.toString();
  String result = '';
  for (int i = 0; i < text.length; i++) {
    if (i > 0 && (text.length - i) % 3 == 0) {
      result += '.';
    }
    result += text[i];
  }
  return 'Rp $result';
}