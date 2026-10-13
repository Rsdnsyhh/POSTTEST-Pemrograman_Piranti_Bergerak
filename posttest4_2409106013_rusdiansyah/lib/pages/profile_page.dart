import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

// halaman profil dibuat stateless namun mendengarkan cartprovider untuk merender data favorit dan riwayat
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: kForest,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kOrange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 56),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Si Pendaki Hebat',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Petualang Aktif',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Akun',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kForest),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email, color: kOrange),
                              const SizedBox(width: 12),
                              Text('pendaki.hebat@gmail.com', style: TextStyle(color: Colors.grey.shade700)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: kOrange),
                              const SizedBox(width: 12),
                              Text('0812-3456-7890', style: TextStyle(color: Colors.grey.shade700)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // sub judul untuk porsi data barang favorit
                    const Text(
                      'Barang Favorit',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kForest),
                    ),
                    const SizedBox(height: 8),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, 3)),
                            ],
                          ),
                          child: cart.favoriteProducts.isEmpty
                              ? Text('Belum ada barang yang disimpan.', style: TextStyle(color: Colors.grey.shade500))
                              : Column(
                            children: cart.favoriteProducts.map((favProduct) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                // row menyusun miniatur gambar dan info barang yang difavoritkan
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.asset(favProduct.imgPath, fit: BoxFit.cover),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(favProduct.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                          Text(formatRupiah(favProduct.price), style: const TextStyle(color: kOrange, fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Riwayat Transaksi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kForest),
                    ),
                    const SizedBox(height: 8),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, 3)),
                            ],
                          ),
                          child: cart.rentalHistory.isEmpty
                              ? Text('Belum ada riwayat penyewaan.', style: TextStyle(color: Colors.grey.shade500))
                              : Column(
                            children: cart.rentalHistory.map((historyText) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    const Icon(Icons.history, color: kForest, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(historyText, style: TextStyle(fontSize: 13, color: Colors.grey.shade800)),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}