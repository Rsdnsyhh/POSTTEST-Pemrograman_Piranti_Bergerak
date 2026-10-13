import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'profile_page.dart';

// homepage mengelola state lokal pencarian dan menyambung ke cartprovider
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  String selectedCategory = 'Semua';
  final List<String> categories = ['Semua', 'Tenda', 'Tas', 'Aksesoris'];

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  void openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        final visibleProducts = cart.products.where((product) {
          bool matchSearch = product.name.toLowerCase().contains(searchQuery);
          bool matchCategory = selectedCategory == 'Semua' || product.category == selectedCategory;
          return product.stock > 0 && matchSearch && matchCategory;
        }).toList();

        int totalItems = cart.totalItems;

        List<Widget> rows = [];
        for (int i = 0; i < visibleProducts.length; i += 2) {
          bool hasSecond = i + 1 < visibleProducts.length;
          rows.add(
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: ProductCard(product: visibleProducts[i])),
                const SizedBox(width: 12),
                Expanded(
                  child: hasSecond ? ProductCard(product: visibleProducts[i + 1]) : const SizedBox(),
                ),
              ],
            ),
          );
          rows.add(const SizedBox(height: 12));
        }

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
                    padding: const EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'SIAP MENDAKI?',
                                    style: TextStyle(color: kOrange, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Sewa Alat Camping\n& Outdoor',
                                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: openCart,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(0),
                                      backgroundColor: Colors.white,
                                      foregroundColor: kForest,
                                    ),
                                    child: const Icon(Icons.shopping_cart),
                                  ),
                                ),
                                Positioned(
                                  top: -6,
                                  right: -6,
                                  child: totalItems > 0
                                      ? Container(
                                    width: 20,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: kOrange,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      totalItems > 9 ? '9+' : '$totalItems',
                                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 44,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: openProfile,
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  backgroundColor: Colors.white,
                                  foregroundColor: kForest,
                                ),
                                child: const Icon(Icons.person),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
                          decoration: InputDecoration(
                            hintText: 'Cari tenda, carrier, kompor...',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search, color: kForest),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categories.map((kategori) {
                              bool isActive = selectedCategory == kategori;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ElevatedButton(
                                  onPressed: () => setState(() => selectedCategory = kategori),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isActive ? kOrange : Colors.white,
                                    foregroundColor: isActive ? Colors.white : kForest,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  child: Text(kategori),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // memeriksa isi data produk untuk menukar tampilan grid dengan indikator kosong
              Expanded(
                child: visibleProducts.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // icon pencarian dicoret tanda data tidak ditemukan
                    Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text('Oops, barang tidak ditemukan', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                )
                    : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: rows),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}