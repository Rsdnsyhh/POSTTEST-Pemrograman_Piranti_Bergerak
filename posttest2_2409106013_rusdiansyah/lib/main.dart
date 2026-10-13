import 'package:flutter/material.dart';
import 'pages/cart_page.dart';
import 'widgets/product_card.dart';

// fungsi utama untuk menginisialisasi dan menjalankan state aplikasi flutter
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // materialapp digunakan sebagai root widget untuk mengonfigurasi tema dasar dan routing
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sewa alat camping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // mengimplementasikan scaffold untuk membangun struktur hierarki antarmuka halaman
    return Scaffold(
      backgroundColor: const Color(0xfffdfbf7),
      // menerapkan safearea guna mengamankan render konten dari area status bar sistem
      body: SafeArea(
        // menata komponen kolom pencarian dan daftar produk secara sekuensial vertikal
        child: Column(
          children: [
            // mengalokasikan padding statis di sekitar area instrumen pencarian
            Padding(
              padding: const EdgeInsets.all(16.0),
              // textfield berfungsi sebagai form input bagi pengguna untuk melakukan kueri pencarian
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'cari tenda, carrier, dll...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // memosisikan ikon pencarian pada bagian akhir dari field input
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
            // memastikan kontainer daftar produk terentang maksimal pada sisa viewport
            Expanded(
              // membungkus widget column dengan singlechildscrollview untuk mengaktifkan fungsi gulir
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    // menginisiasi objek productcard dengan passing parameter data yang relevan
                    ProductCard(title: 'Tenda Dome 4 Orang', description: 'Tenda camping kapasitas 4 orang dewasa', stock: '5', price: 'Rp 50.000 / hari', imgPath: 'assets/product.jpg'),
                    ProductCard(title: 'Carrier Consina 60l', description: 'Tas carrier gunung ukuran 60 liter', stock: '8', price: 'Rp 35.000 / hari', imgPath: 'assets/product.jpg'),
                    ProductCard(title: 'Kompor Portabel', description: 'Kompor lipat anti badai untuk masak', stock: '12', price: 'Rp 15.000 / hari', imgPath: 'assets/product.jpg'),
                    ProductCard(title: 'Sleeping Bag Polar', description: 'Kantong tidur bahan polar tebal hangat', stock: '10', price: 'Rp 10.000 / hari', imgPath: 'assets/product.jpg'),
                    ProductCard(title: 'Matras Foil', description: 'Matras alas tidur tahan dingin', stock: '20', price: 'Rp 5.000 / hari', imgPath: 'assets/product.jpg'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // mendefinisikan bilah navigasi statis pada bagian bawah layar antarmuka
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
          // mengonfigurasi boxshadow untuk memberikan kedalaman visual antara navigasi dan konten
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -3),
            )
          ],
        ),
        // mendistribusikan elemen ikon navigasi secara merata dalam satu baris
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavIcon(Icons.home, 'Beranda', true),
            // mendaftarkan fungsi listener sentuhan untuk melakukan transisi halaman
            GestureDetector(
              onTap: () {
                // memanggil fungsi push pada navigator untuk memuat state halaman keranjang
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              child: buildNavIcon(Icons.shopping_cart, 'Keranjang', false),
            ),
            buildNavIcon(Icons.person, 'Profil', false),
          ],
        ),
      ),
    );
  }

  // fungsi helper modular untuk memisahkan logika penyusunan elemen ikon menu
  Widget buildNavIcon(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // container memberikan modifikasi latar belakang dinamis jika menu berstatus aktif
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.shade100 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: isActive ? Colors.green.shade800 : Colors.grey.shade500),
        ),
        const SizedBox(height: 4),
        // merender label teks menu tepat di bawah ikon visual
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