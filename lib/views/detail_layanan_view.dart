import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'total_ulasan_view.dart'; // <-- Pastikan import halaman ulasan ini ada

class DetailLayananView extends StatelessWidget {
  const DetailLayananView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack bagian gambar atas, tombol back, tombol option, dan ikon love
            Stack(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/service_ac.png'), // Ganti sesuai aset gambarmu
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Tombol Back Kiri Atas
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_back, color: AppColors.textBlack, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                // Tombol Option Kanan Atas
                Positioned(
                  top: 40,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_vert, color: AppColors.textBlack, size: 18),
                      onPressed: () {},
                    ),
                  ),
                ),
                // Tombol Love Kanan Bawah Gambar
                Positioned(
                  bottom: 10,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                    ),
                    child: const Icon(Icons.favorite, color: Colors.red, size: 24),
                  ),
                )
              ],
            ),
            
            // Konten Detail
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Layanan Utama
                  const Text(
                    'Service AC Split',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                  ),
                  const SizedBox(height: 10),
                  
                  // Baris Badge (Rating, Verifikasi, dan Link Ulasan)
                  Row(
                    children: [
                      _buildBadge('★ 4.9', const Color(0xFFFFF0EB), AppColors.primaryOrange),
                      const SizedBox(width: 8),
                      _buildBadge('✓ Terverifikasi', const Color(0xFFE6F9EE), AppColors.successGreen),
                      const SizedBox(width: 8),
                      
                      // ==========================================
                      // SAMBUNGAN KLIK MENU ULASAN:
                      // ==========================================
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TotalUlasanView()),
                          );
                        },
                        child: _buildBadge('135 Ulasan', Colors.grey[200]!, AppColors.textGrey),
                      ),
                      // ==========================================
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Tentang Layanan
                  const Text('Tentang Layanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                  const SizedBox(height: 6),
                  const Text(
                    'Service AC meliputi pembersihan filter, evaporator, dan pengecekan freon. Teknisi berpengalaman minimal 3 tahun.',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  
                  // Yang Sudah Termasuk
                  const Text('Yang sudah termasuk', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                  const SizedBox(height: 10),
                  _buildIncludeItem('Pembersihan filter & evaporator'),
                  _buildIncludeItem('Pengecekan kondisi freon'),
                  _buildIncludeItem('Garansi servis 7 hari'),
                  _buildIncludeItem('Spare part dasar gratis'),
                  const SizedBox(height: 20),
                  
                  // Syarat & Garansi
                  const Text('Syarat & Garansi', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                  const SizedBox(height: 50), // Jarak space bawah sebelum bottom bar
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation Bar untuk Harga dan Pesan Sekarang
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.lightGrey)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mulai dari', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: const [
                    Text('Rp 120k ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                    Text('/ unit', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Beri fungsi navigasi ke halaman checkout order jika ada
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text(
                'Pesan Sekarang',
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Komponen Reusable item checklist kriteria include
  Widget _buildIncludeItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.primaryOrange, size: 16),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textBlack)),
        ],
      ),
    );
  }

  // Komponen Reusable pembuat kotak badge status
  Widget _buildBadge(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }
}