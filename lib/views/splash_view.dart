import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'login_view.dart'; // Memastikan import halaman Login untuk navigasi setelah timer selesai

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Menjalankan Timer selama 3 detik sebelum berpindah ke halaman Lgin
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar agar responsif di berbagai perangkat
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // Menyamakan warna theme utama aplikasi
      backgroundColor: AppColors.primaryOrange,
      body: Stack(
        children: [
          // 1. Ornamen Lingkaran Besar Samar di Pojok Kiri Atas
          Positioned(
            top: -screenWidth * 0.3,
            left: -screenWidth * 0.3,
            child: Container(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Menggunakan putih dengan opacity rendah agar samar-samar estetis
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // 2. Ornamen Lingkaran Besar Samar di Pojok Kanan Bawah
          Positioned(
            bottom: -screenWidth * 0.4,
            right: -screenWidth * 0.3,
            child: Container(
              width: screenWidth * 0.9,
              height: screenWidth * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // 3. Konten Utama di Tengah Layar
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // A. Ikon Perkakas (Palu & Kunci Pas)
                  // Menggunakan Icon bawaan Flutter yang paling mendekati ilustrasi gambar Anda
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.build, // Ikon kunci pas
                        size: screenWidth * 0.25,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // B. Teks Logo "FixNow"
                  const Text(
                    'FixNow',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // C. Teks Slogan/Sub-judul
                  const Text(
                    'Solusi Perbaikan rumah & Elektronik Terpercaya',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
