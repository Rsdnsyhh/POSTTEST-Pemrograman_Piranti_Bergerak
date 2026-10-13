import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/product.dart';
import 'pages/home_page.dart';
import 'providers/cart_provider.dart';

// fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(
    // multiprovider menjadi tempat mendaftarkan provider yang dibutuhkan aplikasi
    MultiProvider(
      providers: [
        // changenotifierprovider membuat dan menyediakan cartprovider ke seluruh widget di bawahnya
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

// mainapp tidak lagi menyimpan state karena state sudah dikelola oleh cartprovider
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // materialapp sebagai widget utama yang membungkus seluruh aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sewa Alat Camping & Outdoor',
      // themedata mengatur tampilan umum aplikasi, warna dasar diambil dari kforest
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kForest),
      ),
      // homepage menjadi halaman pertama yang ditampilkan
      home: const HomePage(),
    );
  }
}