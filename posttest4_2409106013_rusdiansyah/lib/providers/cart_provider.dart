import 'package:flutter/material.dart';
import '../models/product.dart';

// provider pengelola state utama untuk data produk, keranjang, riwayat, dan favorit
class CartProvider extends ChangeNotifier {
  final List<Product> products = [
    Product(id: 'P001', name: 'Tenda Dome 4 Orang', description: 'Tenda camping kapasitas 4 orang dewasa', imgPath: 'assets/product.jpg', category: 'Tenda', price: 50000, stock: 5),
    Product(id: 'P002', name: 'Carrier Consina 60L', description: 'Tas carrier gunung ukuran 60 liter', imgPath: 'assets/product.jpg', category: 'Tas', price: 35000, stock: 8),
    Product(id: 'P003', name: 'Kompor Portabel', description: 'Kompor lipat anti badai untuk masak', imgPath: 'assets/product.jpg', category: 'Aksesoris', price: 15000, stock: 12),
    Product(id: 'P004', name: 'Sleeping Bag Polar', description: 'Kantong tidur bahan polar tebal hangat', imgPath: 'assets/product.jpg', category: 'Aksesoris', price: 10000, stock: 10),
    Product(id: 'P005', name: 'Matras Foil', description: 'Matras alas tidur tahan dingin', imgPath: 'assets/product.jpg', category: 'Aksesoris', price: 5000, stock: 20),
    Product(id: 'P006', name: 'Headlamp LED', description: 'Lampu kepala LED 3 mode untuk jalan malam', imgPath: 'assets/product.jpg', category: 'Aksesoris', price: 8000, stock: 15),
  ];

  final Map<String, int> cartQuantities = {};
  final List<String> rentalHistory = [];

  // list penyimpan id barang yang disukai pengguna
  final List<String> favoriteIds = [];

  // memeriksa apakah sebuah produk ada di daftar favorit
  bool isFavorite(String id) {
    return favoriteIds.contains(id);
  }

  // menambah atau menghapus produk dari daftar favorit
  void toggleFavorite(String id) {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
    notifyListeners(); // memperbarui tampilan tombol hati dan profil
  }

  // menyaring dan mengembalikan daftar produk yang berstatus favorit
  List<Product> get favoriteProducts {
    return products.where((p) => favoriteIds.contains(p.id)).toList();
  }

  int quantityOf(Product product) {
    return cartQuantities[product.id] ?? 0;
  }

  int get totalItems => products.fold(0, (total, product) {
    return total + (cartQuantities[product.id] ?? 0);
  });

  int get grandTotal => products.fold(0, (total, product) {
    return total + product.price * (cartQuantities[product.id] ?? 0);
  });

  List<Product> get cartItems {
    return products.where((product) {
      return (cartQuantities[product.id] ?? 0) > 0;
    }).toList();
  }

  void addToCart(Product product) {
    if (product.stock == 0) return;
    product.stock--;
    cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + 1;
    notifyListeners();
  }

  void changeQuantity(Product product, int quantity) {
    int current = cartQuantities[product.id] ?? 0;
    int maxQuantity = product.stock + current;
    int fixed = quantity.clamp(1, maxQuantity).toInt();
    product.stock = product.stock + current - fixed;
    cartQuantities[product.id] = fixed;
    notifyListeners();
  }

  void removeFromCart(Product product) {
    int current = cartQuantities[product.id] ?? 0;
    product.stock += current;
    cartQuantities[product.id] = 0;
    notifyListeners();
  }

  void checkout() {
    if (grandTotal > 0) {
      String history = 'Menyewa $totalItems barang dengan total tagihan ${formatRupiah(grandTotal)}';
      rentalHistory.insert(0, history);
    }
    for (Product product in products) {
      cartQuantities[product.id] = 0;
    }
    notifyListeners();
  }
}