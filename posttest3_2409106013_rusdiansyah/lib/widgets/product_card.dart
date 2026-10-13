import 'package:flutter/material.dart';
import '../models/product.dart';

// widget kartu untuk menampilkan informasi produk secara vertikal
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // memeriksa ketersediaan stok, mengembalikan true jika jumlah di keranjang sudah sama dengan stok
    final bool isMaxed = product.qty >= product.stock;

    // container digunakan untuk membungkus kartu produk dengan desain sudut melengkung dan bayangan
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // column untuk menyusun gambar di bagian atas, lalu teks dan tombol di bagian bawah
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // stack digunakan untuk menumpuk gambar produk dengan label informasi stok dan harga
          Stack(
            children: [
              // menampilkan gambar produk dari folder assets dengan ukuran yang menyesuaikan
              Image.asset(
                product.imgPath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
              // memposisikan lencana informasi stok di sudut kiri atas
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: kForest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Stok ${product.stock}',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // memposisikan label harga per hari di sudut kanan bawah
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: kOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${formatRupiah(product.price)}/hari',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // memberi jarak (padding) di sekitar area teks dan tombol
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // menampilkan nama produk, dipotong jika melebihi satu baris
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                // mengatur tinggi tetap agar semua ukuran kartu produk tetap seragam walau panjang deskripsi berbeda
                SizedBox(
                  height: 32,
                  child: Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(height: 8),
                // tombol untuk menambahkan barang ke keranjang, dinonaktifkan secara otomatis jika stok maksimal
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isMaxed ? null : onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kForest,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                    ),
                    child: Text(
                      isMaxed ? 'Stok Maksimal' : 'Tambah ke Keranjang',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}