import 'package:flutter/material.dart';

// modul render spesifik untuk memanajemen instansiasi objek saat berada di sistem keranjang
class CartProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String stock;
  final String price;
  final String imgPath;

  const CartProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.stock,
    required this.price,
    required this.imgPath
  });

  @override
  Widget build(BuildContext context) {
    // menyusun parameter pembatas antara tiap unit iterasi produk dalam array keranjang
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      // mempartisi tata letak menjadi segmen gambar, metadata, dan controller numerik
      child: Row(
        children: [
          // menafsirkan berkas gambar lokal dari rute aset ke dalam elemen visual ui
          Image.asset(
            imgPath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          // mengakomodasi persentase sisa viewport horizontal untuk string metadata
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.orange.shade800),
                ),
                const SizedBox(height: 4),
                Text(
                  'Stok tersisa: $stock',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          // membungkus logika dan antarmuka instrumen modifikasi variabel kuantitas
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // merepresentasikan titik interaksi untuk eksekusi algoritma pengurangan
                GestureDetector(
                  onTap: () {
                    // inisialisasi state decrement akan diformulasikan pada modul lanjut
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Icon(Icons.remove, size: 16, color: Colors.grey.shade600),
                  ),
                ),
                // mengatur limitasi ukuran field guna menjaga integritas layout antarmuka
                SizedBox(
                  width: 30,
                  // mengimplementasikan textfield murni sesuai kaidah penulisan pada modul dasar
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      hintText: '1',
                    ),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                // merepresentasikan titik interaksi untuk eksekusi algoritma penambahan
                GestureDetector(
                  onTap: () {
                    // inisialisasi state increment akan diformulasikan pada modul lanjut
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Icon(Icons.add, size: 16, color: Colors.green.shade800),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}