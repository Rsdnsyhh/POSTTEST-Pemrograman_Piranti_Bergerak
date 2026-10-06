import 'package:flutter/material.dart';
import 'models/product.dart';
import 'pages/home_page.dart';

// fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(const MainApp());
}

// mainapp dibuat statefulwidget untuk menyimpan state utama daftar produk dan isi keranjang
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // inisialisasi data produk. qty merepresentasikan jumlah di keranjang, stock adalah stok tersedia
  final List<Product> products = [
    Product(name: 'Tenda Dome 4 Orang', description: 'Tenda camping kapasitas 4 orang dewasa', imgPath: 'assets/product.jpg', price: 50000, stock: 5),
    Product(name: 'Carrier Consina 60L', description: 'Tas carrier gunung ukuran 60 liter', imgPath: 'assets/product.jpg', price: 35000, stock: 8),
    Product(name: 'Kompor Portabel', description: 'Kompor lipat anti badai untuk masak', imgPath: 'assets/product.jpg', price: 15000, stock: 12),
    Product(name: 'Sleeping Bag Polar', description: 'Kantong tidur bahan polar tebal hangat', imgPath: 'assets/product.jpg', price: 10000, stock: 10),
    Product(name: 'Matras Foil', description: 'Matras alas tidur tahan dingin', imgPath: 'assets/product.jpg', price: 5000, stock: 20),
    Product(name: 'Headlamp LED', description: 'Lampu kepala LED 3 mode untuk jalan malam', imgPath: 'assets/product.jpg', price: 8000, stock: 15),
  ];

  // fungsi untuk menambah barang ke keranjang selama stok masih tersedia
  void addToCart(Product product) {
    setState(() {
      if (product.qty < product.stock) product.qty++;
    });
  }

  // fungsi untuk mengubah jumlah barang di keranjang sesuai input, dibatasi dari 1 sampai batas stok
  void changeQuantity(Product product, int quantity) {
    setState(() {
      product.qty = quantity.clamp(1, product.stock).toInt();
    });
  }

  // fungsi untuk menghapus barang dari keranjang secara langsung
  void removeFromCart(Product product) {
    setState(() {
      product.qty = 0;
    });
  }

  // fungsi checkout untuk mengurangi stok produk berdasarkan jumlah di keranjang lalu meresetnya
  void checkout() {
    setState(() {
      for (final product in products) {
        product.stock -= product.qty;
        product.qty = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // materialapp sebagai wrapper utama aplikasi untuk mengatur tema dan halaman awal
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sewa Alat Camping & Outdoor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kForest),
      ),
      home: HomePage(
        products: products,
        onAddToCart: addToCart,
        onChangeQuantity: changeQuantity,
        onRemove: removeFromCart,
        onCheckout: checkout,
      ),
    );
  }
}