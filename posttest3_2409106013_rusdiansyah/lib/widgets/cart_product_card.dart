import 'package:flutter/material.dart';
import '../models/product.dart';

// cartproductcard dibuat statefulwidget karena membutuhkan texteditingcontroller untuk mengelola input jumlah secara mandiri
class CartProductCard extends StatefulWidget {
  final Product product;
  final int quantity;
  final int maxQuantity;
  final void Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.maxQuantity,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late TextEditingController quantityController;

  // initstate dipanggil untuk mengisi nilai awal pada controller sesuai dengan jumlah barang saat kartu dimuat
  @override
  void initState() {
    super.initState();
    quantityController = TextEditingController(text: '${widget.quantity}');
  }

  // didupdatewidget digunakan agar teks pada controller tetap sinkron apabila terdapat perubahan jumlah dari luar widget
  @override
  void didUpdateWidget(covariant CartProductCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity &&
        quantityController.text != '${widget.quantity}') {
      quantityController.text = '${widget.quantity}';
    }
  }

  // membuang resource controller dari memori saat widget dihapus untuk mencegah kebocoran memori (memory leak)
  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  // fungsi validasi input: mengonversi teks ke angka, menolak nilai tidak valid, dan membatasi input agar tidak melebihi stok
  void updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;
    final fixed = parsed.clamp(1, widget.maxQuantity).toInt();

    // memperbarui tampilan teks di controller jika input pengguna melampaui batas yang diizinkan
    if ('$fixed' != value) quantityController.text = '$fixed';
    widget.onQuantityChanged(fixed);
  }

  @override
  Widget build(BuildContext context) {
    // container sebagai pembungkus setiap item di dalam keranjang
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      // row untuk menyusun letak gambar produk di sisi kiri dan detail produk di sisi kanan
      child: Row(
        children: [
          // bingkai gambar produk dengan gaya sudut melengkung
          Container(
            width: 84,
            height: 84,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Image.asset(widget.product.imgPath, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          // detail produk dibuat fleksibel untuk mengisi sisa ruang layar yang tersedia
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // menyusun nama produk berdampingan dengan tombol hapus
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // tombol ikon tempat sampah untuk menghapus produk dari keranjang
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: widget.onRemove,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                        ),
                        child: const Icon(Icons.delete_outline, size: 18),
                      ),
                    ),
                  ],
                ),
                // menampilkan teks harga satuan per hari
                Text(
                  '${formatRupiah(widget.product.price)} / hari',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                // baris interaksi untuk menambah/mengurangi jumlah barang beserta total harga sub-item
                Row(
                  children: [
                    // tombol kurangi (minus), dinonaktifkan secara otomatis jika jumlah produk sudah mencapai batas minimal 1
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: widget.quantity > 1
                            ? () => widget.onQuantityChanged(widget.quantity - 1)
                            : null,
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    // textfield untuk menerima input jumlah produk dari pengguna secara manual
                    SizedBox(
                      width: 44,
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
                    // tombol tambah (plus), dinonaktifkan secara otomatis jika jumlah produk telah mencapai batas maksimal stok
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: widget.quantity < widget.maxQuantity
                            ? () => widget.onQuantityChanged(widget.quantity + 1)
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: kForest,
                          foregroundColor: Colors.white,
                        ),
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ),
                    // subtotal produk, mengkalkulasi harga dasar dikalikan kuantitas
                    Expanded(
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