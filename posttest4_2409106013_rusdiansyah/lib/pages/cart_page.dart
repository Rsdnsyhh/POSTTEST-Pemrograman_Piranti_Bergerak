import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_product_card.dart';

// cartpage menjadi statelesswidget karena isi keranjang sudah dikelola oleh cartprovider
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // checkout: total diambil lebih dulu, keranjang dikosongkan lewat cartprovider,
  // kemudian pengguna dipindahkan ke halaman konfirmasi
  void checkout(BuildContext context) {
    final total = context.read<CartProvider>().grandTotal;
    context.read<CartProvider>().checkout();
    Navigator.push(
      context,
      // materialpageroute membuat rute menuju checkoutpage
      MaterialPageRoute(builder: (context) => CheckoutPage(total: total)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // consumer mendengarkan perubahan pada cartprovider, halaman dibangun ulang saat isi keranjang berubah
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        // hanya produk yang ada di keranjang yang ditampilkan
        final cartItems = cart.cartItems;
        int grandTotal = cart.grandTotal;

        // membuat kartu keranjang untuk setiap barang menggunakan perulangan for
        List<Widget> cartCards = [];
        for (Product item in cartItems) {
          cartCards.add(
            // cartproductcard menampilkan satu barang di keranjang
            CartProductCard(
              product: item,
              quantity: cart.quantityOf(item),
              maxQuantity: item.stock + cart.quantityOf(item),
            ),
          );
        }

        // scaffold menjadi kerangka dasar halaman keranjang
        return Scaffold(
          backgroundColor: kCream,
          // column menyusun header dan daftar barang
          body: Column(
            children: [
              // container sebagai latar header berwarna hijau tua
              Container(
                width: double.infinity,
                color: kForest,
                // safearea agar header tidak tertutup status bar perangkat
                child: SafeArea(
                  bottom: false,
                  // padding memberi ruang di sekeliling header
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    // row menyusun tombol kembali dan judul halaman
                    child: Row(
                      children: [
                        // elevatedbutton untuk kembali ke beranda menggunakan navigator.pop
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kOrange,
                            foregroundColor: Colors.white,
                          ),
                          // icon panah kembali
                          child: const Icon(Icons.arrow_back),
                        ),
                        // sizedbox sebagai jarak antara tombol dan judul
                        const SizedBox(width: 12),
                        // expanded agar judul memakai sisa lebar
                        Expanded(
                          // column menyusun judul dan jumlah jenis barang
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // text untuk judul halaman
                              const Text(
                                'Keranjang Sewa',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              // text untuk jumlah jenis barang di keranjang
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
              // expanded agar daftar barang mengisi sisa tinggi layar
              Expanded(
                // singlechildscrollview agar daftar dapat di-scroll
                child: SingleChildScrollView(
                  // padding memberi jarak di tepi daftar
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    // column berisi kartu barang, atau pesan jika keranjang kosong
                    child: Column(
                      children: cartItems.isEmpty
                          ? [
                        // sizedbox sebagai jarak di atas pesan kosong
                        const SizedBox(height: 80),
                        // icon sebagai tanda keranjang kosong
                        Icon(Icons.shopping_basket_outlined, size: 64, color: Colors.grey.shade400),
                        // sizedbox sebagai jarak antara ikon dan pesan
                        const SizedBox(height: 8),
                        // text pesan keranjang kosong
                        Text('Keranjang masih kosong', style: TextStyle(color: Colors.grey.shade600)),
                      ]
                          : cartCards,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // container sebagai panel total harga dan tombol checkout di bagian bawah
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              // boxshadow memberi bayangan ke arah atas panel
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            // safearea agar panel tidak tertutup gesture bar di bagian bawah
            child: SafeArea(
              top: false,
              // row menyusun total di kiri dan tombol di kanan
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // column menyusun label dan nilai total
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // text label total
                      const Text('Total sewa / hari', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      // text nilai total
                      Text(
                        formatRupiah(grandTotal),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kForest),
                      ),
                    ],
                  ),
                  // elevatedbutton checkout, nonaktif (null) jika total masih 0
                  ElevatedButton(
                    onPressed: grandTotal > 0 ? () => checkout(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    ),
                    // text label tombol checkout
                    child: const Text('Checkout'),
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

// halaman konfirmasi yang tampil setelah checkout berhasil
class CheckoutPage extends StatelessWidget {
  final int total;

  const CheckoutPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    // scaffold menjadi kerangka dasar halaman konfirmasi
    return Scaffold(
      backgroundColor: kForest,
      // safearea agar tampilan tidak tertutup status bar perangkat
      body: SafeArea(
        // padding memberi jarak di tepi halaman
        child: Padding(
          padding: const EdgeInsets.all(24),
          // column menyusun seluruh isi halaman di tengah layar
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // container sebagai latar bulat ikon centang
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kOrange,
                  borderRadius: BorderRadius.circular(60),
                ),
                // icon centang sebagai tanda berhasil
                child: const Icon(Icons.check, color: Colors.white, size: 56),
              ),
              // sizedbox sebagai jarak antara ikon dan judul
              const SizedBox(height: 24),
              // text judul konfirmasi
              const Text(
                'Sewa Berhasil!',
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
              ),
              // sizedbox sebagai jarak antara judul dan pesan
              const SizedBox(height: 8),
              // text pesan penutup
              const Text(
                'Selamat berpetualang, jaga alamnya ya.',
                style: TextStyle(color: Colors.white70),
              ),
              // sizedbox sebagai jarak sebelum kartu total
              const SizedBox(height: 24),
              // container sebagai kartu total pembayaran
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kCream,
                  borderRadius: BorderRadius.circular(18),
                ),
                // column menyusun label dan nominal total
                child: Column(
                  children: [
                    // text label total pembayaran
                    const Text('Total Pembayaran', style: TextStyle(color: Colors.grey)),
                    // sizedbox sebagai jarak antara label dan nominal
                    const SizedBox(height: 4),
                    // text nominal total pembayaran
                    Text(
                      formatRupiah(total),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kForest),
                    ),
                  ],
                ),
              ),
              // sizedbox sebagai jarak sebelum tombol kembali
              const SizedBox(height: 24),
              // sizedbox agar tombol selebar layar
              SizedBox(
                width: double.infinity,
                // elevatedbutton untuk kembali ke beranda, navigator.pop dipanggil dua kali
                // untuk menutup halaman ini lalu halaman keranjang
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
                  // text label tombol kembali
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