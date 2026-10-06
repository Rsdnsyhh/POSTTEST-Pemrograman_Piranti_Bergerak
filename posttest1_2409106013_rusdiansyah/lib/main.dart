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
    // scaffold menyediakan struktur dasar halaman seperti body dan bilah navigasi
    return Scaffold(
      backgroundColor: const Color(0xfffdfbf7),
      // safearea memastikan konten tidak terpotong oleh poni (notch) atau status bar perangkat
      body: SafeArea(
        // column digunakan untuk menyusun widget pencarian dan daftar produk secara vertikal
        child: Column(
          children: [
            // padding memberikan jarak kosong di sekeliling widget input pencarian
            Padding(
              padding: const EdgeInsets.all(16.0),
              // textfield berfungsi sebagai kolom input untuk fitur pencarian alat camping
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'cari tenda, carrier, dll...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  // padding digunakan untuk memberikan jarak pada ikon di dalam kolom input
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    // icon menambahkan gambar kaca pembesar sebagai penanda fitur cari
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
            // expanded memaksa area daftar produk untuk mengisi sisa ruang kosong pada layar
            Expanded(
              // singlechildscrollview memungkinkan daftar produk untuk dapat digulir (scroll) ke bawah
              child: SingleChildScrollView(
                // column menyusun sekumpulan kartu produk secara vertikal dari atas ke bawah
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
      // container digunakan sebagai latar belakang dan pembatas untuk bilah navigasi bawah
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        // row menyusun ikon menu beranda, keranjang, dan profil secara horizontal menyamping
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

  // fungsi tambahan untuk mempermudah pembuatan kartu produk berulang kali
  Widget buildProductCard(String title, String price) {
    // container berfungsi sebagai pembungkus utama yang membentuk kotak kartu produk
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      // row digunakan untuk menyejajarkan area gambar dengan area detail teks ke samping
      child: Row(
        children: [
          // container ini digunakan sebagai tempat penampung (placeholder) gambar produk
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400),
            ),
          ),
          // sizedbox memberikan jeda atau jarak horizontal antara kotak gambar dan detail produk
          const SizedBox(width: 16),
          // expanded memastikan area teks memanjang dan mengisi sisa lebar kartu yang tersedia
          Expanded(
            // column menyusun elemen judul, harga, dan tombol sewa dari atas ke bawah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // text bertugas menampilkan informasi judul produk
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // sizedbox memberikan jarak vertikal antara teks judul dan teks harga
                const SizedBox(height: 4),
                // text bertugas menampilkan informasi harga sewa produk
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade800,
                  ),
                ),
                // sizedbox memberikan jarak vertikal sebelum menampilkan tombol masuk keranjang
                const SizedBox(height: 12),
                // container digunakan untuk membentuk desain kotak tombol penyewaan
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  // row menyusun ikon keranjang dan teks pada tombol secara berdampingan
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // icon menampilkan gambar keranjang belanja pada tombol
                      Icon(Icons.shopping_cart_checkout, color: Colors.white, size: 16),
                      // sizedbox memberikan sedikit jarak antara ikon keranjang dan label teks
                      SizedBox(width: 6),
                      // text menampilkan label instruksi pada tombol penyewaan
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

  // fungsi tambahan untuk menyusun tata letak ikon beserta label teksnya pada navigasi bawah
  Widget buildNavIcon(IconData icon, String label, bool isActive) {
    // column menyusun ikon berada di posisi atas dan teks label di posisi bawahnya
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // icon menampilkan gambar menu navigasi yang dipilih
        Icon(
          icon,
          color: isActive ? Colors.green.shade800 : Colors.grey.shade400,
        ),
        // sizedbox memberikan jarak vertikal antara gambar ikon menu dan teks labelnya
        const SizedBox(height: 4),
        // text menampilkan nama label dari menu navigasi tersebut
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