import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/cart_product_card.dart';

// cartpage dibuat statefulwidget agar tampilan keranjang dapat dirender ulang setiap ada perubahan kuantitas atau penghapusan item
class CartPage extends StatefulWidget {
  final List<Product> products;
  final void Function(Product, int) onChangeQuantity;
  final void Function(Product) onRemove;
  final VoidCallback onCheckout;

  const CartPage({
    super.key,
    required this.products,
    required this.onChangeQuantity,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // fungsi checkout untuk menjalankan callback pengosongan keranjang, lalu melakukan navigasi ke halaman sukses
  void checkout(int total) {
    widget.onCheckout();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage(total: total)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // menyaring daftar produk dan hanya menyimpan item yang memiliki kuantitas lebih dari nol (berada di keranjang)
    final cartItems = widget.products.where((p) => p.qty > 0).toList();
    int grandTotal = 0;
    for (final item in cartItems) {
      grandTotal += item.qty * item.price;
    }

    // kerangka halaman utama untuk keranjang belanja
    return Scaffold(
      backgroundColor: kCream,
      body: Column(
        children: [
          // area header keranjang, diberikan pembungkus safearea agar tidak bertumpuk dengan status bar perangkat
          Container(
            width: double.infinity,
            color: kForest,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // tombol navigasi untuk kembali ke halaman sebelumnya
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kOrange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Keranjang Sewa',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          // menampilkan ringkasan jumlah variasi item yang ada di dalam keranjang
                          Text(
                            '${cartItems.length} jenis barang',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // area untuk menampilkan daftar item produk menggunakan fungsi scroll
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: cartItems.isEmpty
                      ? [
                    // menampilkan pesan dan ikon penanda apabila keranjang saat ini masih kosong
                    const SizedBox(height: 80),
                    Icon(Icons.shopping_basket_outlined, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('Keranjang masih kosong', style: TextStyle(color: Colors.grey.shade600)),
                  ]
                      : cartItems.map((item) {
                    // melooping data item yang ada di keranjang untuk ditampilkan dalam bentuk kartu
                    return CartProductCard(
                      product: item,
                      quantity: item.qty,
                      maxQuantity: item.stock,
                      onQuantityChanged: (q) {
                        widget.onChangeQuantity(item, q);
                        setState(() {}); // memperbarui UI setelah ada perubahan nilai pada kuantitas item
                      },
                      onRemove: () {
                        widget.onRemove(item);
                        setState(() {}); // memperbarui UI setelah ada item yang dihapus
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomnavigationbar digunakan untuk panel statis di bawah yang menampilkan total tagihan dan tombol aksi checkout
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total sewa / hari', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  // teks total yang format angkanya telah diformat menjadi satuan nilai rupiah
                  Text(
                    formatRupiah(grandTotal),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kForest),
                  ),
                ],
              ),
              // tombol aksi checkout, akan nonaktif apabila total tagihan masih bernilai nol
              ElevatedButton(
                onPressed: grandTotal > 0 ? () => checkout(grandTotal) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// halaman konfirmasi sederhana yang akan muncul apabila transaksi sewa berhasil diproses
class CheckoutPage extends StatelessWidget {
  final int total;

  const CheckoutPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kForest,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: kOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 56),
              ),
              const SizedBox(height: 24),
              const Text(
                'Sewa Berhasil!',
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selamat berpetualang, jaga alamnya ya.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              // menampilkan kotak berisikan rincian ringkasan total uang yang telah dibayarkan pengguna
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kCream,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text('Total Pembayaran', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(
                      formatRupiah(total),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kForest),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                // menggunakan navigator.pop dua kali secara berurutan untuk membuang halaman konfirmasi dan halaman keranjang agar kembali ke beranda utama
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Kembali ke Beranda'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}