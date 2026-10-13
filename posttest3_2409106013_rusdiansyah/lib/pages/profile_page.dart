import 'package:flutter/material.dart';
import '../models/product.dart';

// statelesswidget untuk merender secara statis halaman profil sederhana
class ProfilePage extends StatelessWidget {
  final int totalItems;

  const ProfilePage({super.key, required this.totalItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: kForest,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // widget pembantu (align) untuk mendempetkan posisi tombol kembali secara utuh ke orientasi sisi kiri
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kOrange,
                          foregroundColor: Colors.white,
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    // area wadah pembungkus dengan rupa melingkar (circle) sebagai tempat avatar
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: kOrange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, color: Colors.white, size: 56),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Nama Kamu',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Petualang Aktif',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}