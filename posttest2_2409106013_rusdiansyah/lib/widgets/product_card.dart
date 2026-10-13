import 'package:flutter/material.dart';

// kelas struktural untuk memodelkan representasi visual dari entitas produk
class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String stock;
  final String price;
  final String imgPath;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.stock,
    required this.price,
    required this.imgPath
  });

  @override
  Widget build(BuildContext context) {
    // memformulasikan batas geometri pada kartu list representasi produk
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green.shade100),
        borderRadius: BorderRadius.circular(12),
        // mengimplementasikan properti bayangan guna menambah kedalaman bidang antarmuka
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      // memisahkan matriks tata letak menjadi segmen visual dan parameter tekstual
      child: Row(
        children: [
          // menumpuk elemen gambar dengan widget posisi untuk memenuhi syarat asisten lab
          Stack(
            children: [
              // merender entitas visual gambar menggunakan alokasi aset memori lokal
              Image.asset(
                imgPath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              // menggunakan positioned untuk menempatkan indikator kecil ketersediaan barang
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.green, size: 12),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // menetapkan lebar kontainer teks agar menyesuaikan batas margin kartu
          Expanded(
            // menata secara kaskade vertikal seluruh field data objek produk
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // memuat parameter primer berupa string judul katalog
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // memuat parameter sekunder berupa deskripsi teknis dari objek
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 4),
                // mencetak data ketersediaan barang hasil pembacaan stok
                Text(
                  'Stok: $stock',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                // mencetak data tarif retribusi penyewaan secara format konstan
                Text(
                  price,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.orange.shade800),
                ),
                const SizedBox(height: 12),
                // mendelegasikan ruang deteksi sentuhan pengguna terhadap fungsional tombol
                GestureDetector(
                  onTap: () {
                    // ruang kosong yang dipersiapkan untuk injeksi logika pada posttest mendatang
                  },
                  // mendefinisikan batas area klik menggunakan objek kontainer warna hijau
                  child: Container(
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
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}