import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

// halaman detail produk menggunakan statelesswidget namun menyambung ke cartprovider
class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        bool isEmpty = product.stock == 0;
        bool isFav = cart.isFavorite(product.id);

        // scaffold sebagai kerangka utama halaman detail barang
        return Scaffold(
          backgroundColor: kCream,
          body: Column(
            children: [
              // stack menumpuk gambar produk dengan panel tombol navigasi di atasnya
              Stack(
                children: [
                  // container pembungkus gambar yang memenuhi tinggi atas layar
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.white,
                    child: Image.asset(product.imgPath, fit: BoxFit.contain),
                  ),
                  // safearea membungkus tombol kembali agar tidak terpotong tepi layar perangkat
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // tombol panah kembali ke beranda
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kOrange,
                              foregroundColor: Colors.white,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Icon(Icons.arrow_back),
                          ),
                          // tombol hati penambah favorit yang disambungkan ke cartprovider
                          ElevatedButton(
                            onPressed: () => cart.toggleFavorite(product.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: isFav ? Colors.red : Colors.grey,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // expanded menyusun detail info teks ke sisa layar yang bisa digulir
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // row menyusun judul barang di kiri dan kategori barang di kanan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: kForest),
                              ),
                            ),
                            // container menjadi latar label teks kategori
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: kForest.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(product.category, style: const TextStyle(color: kForest, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // text sisa stok real-time
                        Text('Tersedia: ${product.stock} barang', style: TextStyle(color: Colors.grey.shade600)),
                        const SizedBox(height: 24),
                        const Text('Deskripsi Produk', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kForest)),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // container statis di bagian layar paling bawah untuk panel pemesanan
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, -3)),
              ],
            ),
            child: SafeArea(
              top: false,
              // row menyusun tagihan harga di kiri dan tombol tambah ke keranjang di kanan
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Harga Sewa', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text(
                        '${formatRupiah(product.price)}/hari',
                        style: const TextStyle(color: kOrange, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // elevatedbutton memasukkan ke keranjang, mati secara otomatis (null) jika stok sudah 0
                  ElevatedButton(
                    onPressed: isEmpty ? null : () => cart.addToCart(product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kForest,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: Text(isEmpty ? 'Stok Habis' : 'Tambah Keranjang'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}