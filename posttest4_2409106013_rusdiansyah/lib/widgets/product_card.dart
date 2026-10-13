import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../pages/product_detail_page.dart'; // import halaman detail produk yang baru

// kartu produk bergaya vertikal
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = product.stock == 0;

    // gesturedetector digunakan untuk menangkap aksi tekan (klik) pada seluruh bagian kartu
    return GestureDetector(
      onTap: () {
        // navigator.push berpindah ke halaman detail sambil mengirim data produk yang diklik
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
        );
      },
      // container pembungkus kartu produk dengan gaya sudut melengkung dan bayangan
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              // stack menumpuk gambar, label stok, label harga, dan ikon favorit
              child: Stack(
                children: [
                  Image.asset(
                    product.imgPath,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
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
                  // positioned meletakkan ikon favorit di kanan atas, di dalam consumer agar warnanya bisa berubah saat ditekan
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        bool isFav = cart.isFavorite(product.id);
                        return GestureDetector(
                          onTap: () => cart.toggleFavorite(product.id),
                          // container latar belakang ikon hati yang membulat
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            // pergantian warna dan wujud ikon hati jika produk difavoritkan
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: 32,
                    child: Text(
                      product.description,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isEmpty
                          ? null
                          : () => context.read<CartProvider>().addToCart(product),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kForest,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                      ),
                      child: Text(
                        isEmpty ? 'Stok Habis' : 'Tambah ke Keranjang',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}