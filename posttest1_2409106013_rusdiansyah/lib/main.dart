import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // materialapp digunakan sebagai pembungkus utama aplikasi dan mengatur tema warna
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
    // scaffold menyediakan struktur dasar halaman seperti body dan navigasi
    return Scaffold(
      backgroundColor: const Color(0xfffdfbf7),
      // safearea memastikan konten tidak terpotong oleh poni (notch) atau status bar perangkat
      body: SafeArea(
        // column digunakan untuk menyusun widget secara vertikal dari atas ke bawah
        child: Column(
          children: [
            // padding memberikan jarak kosong di sekeliling widget input
            Padding(
              padding: const EdgeInsets.all(16.0),
              // textfield berfungsi sebagai kolom input untuk fitur pencarian
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'cari tenda, carrier, dll...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // suffixicon menambahkan ikon pada bagian kanan dalam textfield
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.green.shade800,
                    ),
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
            // expanded memaksa widget anak untuk mengisi sisa ruang kosong pada layar
            Expanded(
              // singlechildscrollview memungkinkan daftar produk untuk digulir (scroll)
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildProductCard('tenda dome 4 orang', 'rp 50.000 / hari'),
                    buildProductCard('carrier consina 60l', 'rp 35.000 / hari'),
                    buildProductCard('kompor portabel', 'rp 15.000 / hari'),
                    buildProductCard('sleeping bag polar', 'rp 10.000 / hari'),
                    buildProductCard('matras foil', 'rp 5.000 / hari'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // container digunakan sebagai pembungkus bilah navigasi bawah dengan kustomisasi batas
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        // row menyusun ikon navigasi secara horizontal
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavIcon(Icons.home, 'beranda', true),
            buildNavIcon(Icons.shopping_cart, 'keranjang', false),
            buildNavIcon(Icons.person, 'profil', false),
          ],
        ),
      ),
    );
  }

  // fungsi tambahan untuk mempermudah pembuatan kartu produk tanpa menulis ulang kode
  Widget buildProductCard(String title, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // container digunakan sebagai tempat penampung gambar produk dengan warna solid
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400),
            ),
          ),
          // sizedbox memberikan jarak horizontal antara kotak gambar dan detail produk
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // text menampilkan teks dengan pengaturan gaya huruf tebal
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'sewa sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // fungsi tambahan untuk membuat susunan ikon dan teks pada bilah navigasi
  Widget buildNavIcon(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? Colors.green.shade800 : Colors.grey.shade400,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.green.shade800 : Colors.grey.shade400,
          ),
        )
      ],
    );
  }
}