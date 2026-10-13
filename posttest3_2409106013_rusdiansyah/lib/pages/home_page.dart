import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'profile_page.dart';

// homepage menggunakan statefulwidget karena menyimpan state textfield untuk fitur pencarian produk
class HomePage extends StatefulWidget {
  final List<Product> products;
  final void Function(Product) onAddToCart;
  final void Function(Product, int) onChangeQuantity;
  final void Function(Product) onRemove;
  final VoidCallback onCheckout;

  const HomePage({
    super.key,
    required this.products,
    required this.onAddToCart,
    required this.onChangeQuantity,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // inisialisasi state variabel sebagai wadah penampung teks kata kunci pencarian
  String searchQuery = '';

  // fungsi navigasi menuju halaman keranjang dengan mengirimkan seluruh dependensi callback
  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          products: widget.products,
          onChangeQuantity: widget.onChangeQuantity,
          onRemove: widget.onRemove,
          onCheckout: widget.onCheckout,
        ),
      ),
    );
  }

  // fungsi navigasi menuju ke rincian profil pengguna
  void openProfile(int totalItems) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(totalItems: totalItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // menyaring produk untuk menyembunyikan stok yang sudah kosong dan menampilkan yang sesuai dengan kata pencarian
    final visibleProducts = widget.products.where((product) {
      return product.stock > 0 &&
          product.name.toLowerCase().contains(searchQuery);
    }).toList();

    // variabel penampung turunan untuk mengakumulasikan seluruh total kuantitas barang di keranjang
    int totalItems = 0;
    for (final product in widget.products) {
      totalItems += product.qty;
    }

    // mengonversi data array produk ke dalam bentuk komponen barisan kartu (layout grid dua kolom)
    final List<Widget> rows = [];
    for (int i = 0; i < visibleProducts.length; i += 2) {
      final hasSecond = i + 1 < visibleProducts.length;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // mengisi ruang kolom sebelah kiri
            Expanded(
              child: ProductCard(
                product: visibleProducts[i],
                onAddToCart: () => widget.onAddToCart(visibleProducts[i]),
              ),
            ),
            const SizedBox(width: 12),
            // mengisi ruang kolom sebelah kanan (dibuat widget kosong jika item berjumlah ganjil)
            Expanded(
              child: hasSecond
                  ? ProductCard(
                product: visibleProducts[i + 1],
                onAddToCart: () =>
                    widget.onAddToCart(visibleProducts[i + 1]),
              )
                  : const SizedBox(),
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
          // pembuatan panel header bagian atas aplikasi
          Container(
            width: double.infinity,
            color: kForest,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
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
                        // widget stack difungsikan untuk menumpuk lencana indikator pemberitahuan di atas tombol keranjang
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              width: 44,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: openCart,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.white,
                                  foregroundColor: kForest,
                                ),
                                child: const Icon(Icons.shopping_cart),
                              ),
                            ),
                            // melakukan render kondisi bersyarat untuk memunculkan lencana indikator hanya jika keranjang berisi item
                            if (totalItems > 0)
                              Positioned(
                                top: -6,
                                right: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: kOrange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    totalItems > 99 ? '99+' : '$totalItems',
                                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        // penempatan ikon tombol rute untuk melihat profil
                        SizedBox(
                          width: 44,
                          height: 44,
                          child: ElevatedButton(
                            onPressed: () => openProfile(totalItems),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.white,
                              foregroundColor: kForest,
                            ),
                            child: const Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // instansiasi input pencarian yang mengikat parameter value ke variabel state searchquery saat pengguna mengetik teks
                    TextField(
                      onChanged: (value) =>
                          setState(() => searchQuery = value.toLowerCase()),
                      decoration: InputDecoration(
                        hintText: 'Cari tenda, carrier, kompor...',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search, color: kForest),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // wadah penampil grid daftar produk yang telah diproses sebelumnya
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: rows),
              ),
            ),
          ),
        ],
      ),
    );
  }
}