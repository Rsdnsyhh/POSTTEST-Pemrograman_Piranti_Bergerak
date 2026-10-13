import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

// cartproductcard tetap statefulwidget karena memiliki texteditingcontroller untuk kolom jumlah
class CartProductCard extends StatefulWidget {
  final Product product;
  final int quantity;
  final int maxQuantity;

  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.maxQuantity,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  // controller untuk mengatur isi teks pada kolom jumlah
  final TextEditingController quantityController = TextEditingController();

  // initstate dijalankan sekali saat kartu dibuat, untuk mengisi jumlah awal
  @override
  void initState() {
    super.initState();
    quantityController.text = '${widget.quantity}';
  }

  // didupdatewidget menyamakan teks dengan jumlah terbaru
  // apabila jumlah berubah dari luar kolom teks, misalnya lewat tombol tambah atau kurang
  @override
  void didUpdateWidget(covariant CartProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity &&
        quantityController.text != '${widget.quantity}') {
      quantityController.text = '${widget.quantity}';
    }
  }

  // validasi input: teks diubah menjadi angka, ditolak jika bukan angka atau kurang dari 1,
  // dan dibatasi paling banyak sebesar jumlah maksimal yang boleh disewa
  void updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;
    int fixed = parsed.clamp(1, widget.maxQuantity).toInt();
    // jika angka yang diketik melebihi batas, teks disesuaikan dengan batas tersebut
    if ('$fixed' != value) {
      quantityController.text = '$fixed';
    }
    // perubahan jumlah dikirim ke cartprovider
    context.read<CartProvider>().changeQuantity(widget.product, fixed);
  }

  @override
  Widget build(BuildContext context) {
    // container sebagai pembungkus kartu keranjang
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        // boxshadow memberi bayangan lembut pada kartu
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      // row menyusun gambar di kiri dan detail produk di kanan
      child: Row(
        children: [
          // container sebagai bingkai gambar dengan sudut melengkung
          Container(
            width: 84,
            height: 84,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            // image.asset menampilkan gambar produk
            child: Image.asset(widget.product.imgPath, fit: BoxFit.cover),
          ),
          // sizedbox sebagai jarak antara gambar dan teks
          const SizedBox(width: 12),
          // expanded agar detail produk memakai sisa lebar kartu
          Expanded(
            // column menyusun nama, harga, dan pengatur jumlah
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // row menyusun nama produk dan tombol hapus
                Row(
                  children: [
                    // expanded agar nama produk memakai sisa lebar
                    Expanded(
                      // text untuk nama produk
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // sizedbox menentukan ukuran tombol hapus
                    SizedBox(
                      width: 32,
                      height: 32,
                      // elevatedbutton untuk menghapus barang dari keranjang lewat cartprovider
                      child: ElevatedButton(
                        onPressed: () =>
                            context.read<CartProvider>().removeFromCart(widget.product),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                        ),
                        // icon tempat sampah
                        child: const Icon(Icons.delete_outline, size: 18),
                      ),
                    ),
                  ],
                ),
                // text untuk harga sewa per hari
                Text(
                  '${formatRupiah(widget.product.price)} / hari',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                // sizedbox sebagai jarak sebelum pengatur jumlah
                const SizedBox(height: 8),
                // row menyusun tombol kurang, kolom jumlah, tombol tambah, dan subtotal
                Row(
                  children: [
                    // sizedbox menentukan ukuran tombol kurang
                    SizedBox(
                      width: 32,
                      height: 32,
                      // elevatedbutton untuk mengurangi jumlah, nonaktif jika jumlah sudah 1
                      child: ElevatedButton(
                        onPressed: widget.quantity > 1
                            ? () => context.read<CartProvider>().changeQuantity(widget.product, widget.quantity - 1)
                            : null,
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(0)),
                        // icon tanda kurang
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    // sizedbox menentukan lebar kolom jumlah
                    SizedBox(
                      width: 44,
                      // textfield untuk mengetik jumlah secara manual,
                      // isinya diperiksa oleh fungsi updatequantity
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: updateQuantity,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // sizedbox menentukan ukuran tombol tambah
                    SizedBox(
                      width: 32,
                      height: 32,
                      // elevatedbutton untuk menambah jumlah, nonaktif jika sudah mencapai batas maksimal
                      child: ElevatedButton(
                        onPressed: widget.quantity < widget.maxQuantity
                            ? () => context.read<CartProvider>().changeQuantity(widget.product, widget.quantity + 1)
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: kForest,
                          foregroundColor: Colors.white,
                        ),
                        // icon tanda tambah
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ),
                    // expanded agar subtotal berada di sisi kanan
                    Expanded(
                      // text untuk subtotal, yaitu harga dikali jumlah
                      child: Text(
                        formatRupiah(widget.product.price * widget.quantity),
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: kOrange),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}