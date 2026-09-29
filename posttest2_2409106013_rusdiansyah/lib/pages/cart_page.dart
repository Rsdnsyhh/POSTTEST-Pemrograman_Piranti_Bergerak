import 'package:flutter/material.dart';
import '../widgets/cart_product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // mendefinisikan kerangka halaman independen untuk modul keranjang sewa
    return Scaffold(
      backgroundColor: const Color(0xfffdfbf7),
      body: SafeArea(
        child: Column(
          children: [
            // menerapkan ruang padding statis pada area header keranjang
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // menangkap instruksi ketukan untuk memicu operasi pengembalian rute
                  GestureDetector(
                    onTap: () {
                      // melakukan pemanggilan metode pop untuk mendestruksi halaman aktif
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Keranjang Sewa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // mengalokasikan field pencarian spesifik untuk utilitas pencarian item internal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'cari barang di keranjang...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.search, size: 24, color: Colors.green.shade800),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green.shade800, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // memanfaatkan proporsi sisa viewport untuk menampilkan koleksi data keranjang
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    CartProductCard(title: 'Tenda Dome 4 Orang', description: 'Tenda camping kapasitas 4 orang dewasa', stock: '5', price: 'Rp 50.000 / hari', imgPath: 'assets/product.jpg'),
                    CartProductCard(title: 'Kompor Portabel', description: 'Kompor lipat anti badai untuk masak', stock: '12', price: 'Rp 15.000 / hari', imgPath: 'assets/product.jpg'),
                  ],
                ),
              ),
            ),
            // merangkai segmen kalkulasi beban biaya dan modul eksekusi checkout
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // menyajikan representasi data total dari keseluruhan transaksi
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        'Rp 65.000',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                      ),
                    ],
                  ),
                  // memformat kontainer sebagai antarmuka tombol validasi checkout
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.shopping_cart, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text('Checkout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // menduplikasi bilah navigasi utama untuk menjaga konsistensi state UI
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // mendelegasikan event listener untuk mengakhiri sesi halaman aktif
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: buildNavIcon(Icons.home, 'Beranda', false),
            ),
            // mendeklarasikan boolean true pada argumen keranjang untuk indikator posisi saat ini
            buildNavIcon(Icons.shopping_cart, 'Keranjang', true),
            buildNavIcon(Icons.person, 'Profil', false),
          ],
        ),
      ),
    );
  }

  // memisahkan logika penyusunan elemen visual navigasi agar dapat digunakan secara berulang
  Widget buildNavIcon(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.shade100 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: isActive ? Colors.green.shade800 : Colors.grey.shade500),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? Colors.green.shade800 : Colors.grey.shade500,
          ),
        )
      ],
    );
  }
}