import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TotalUlasanView extends StatelessWidget {
  const TotalUlasanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // <-- Sudah diperbaiki dari CenterNavigator
          children: [
            const SizedBox(height: 10),
            
            // Angka Rating Besar Utama (Sesuai Desain Figma Sebelah Kanan)
            const Text(
              '4.75',
              style: TextStyle(
                fontSize: 48, 
                fontWeight: FontWeight.bold, 
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 5),
            
            // Baris Bintang Rating Utama
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => const Icon(Icons.star, color: Colors.amber, size: 26),
              ),
            ),
            const SizedBox(height: 6),
            
            // Total Jumlah Reviewers
            const Text(
              '(345 Review)', 
              style: TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
            const SizedBox(height: 35),
            
            // Judul List Komentar
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Most Liked Comments',
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold, 
                  color: AppColors.textBlack,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Kumpulan Kartu Ulasan Konsumen (Sesuai isi Figma)
            _buildCommentCard(
              name: 'Sativa Attha', 
              date: '18 April 2025', 
              comment: 'Permisi kak untuk Jasa Cleaning Servisnya hari ini sangat memuaskan sekali. Teknisi datang tepat waktu dan pengerjaannya sangat rapi & bersih. Recommended banget!', 
              likes: '287',
            ),
            _buildCommentCard(
              name: 'Adhiana Alika', 
              date: '1 Juni 2025', 
              comment: 'Harga terjangkau, pengerjaan cepat dan ramah banget mas-mas teknisinya. AC rumah sekarang jadi dingin banget kayak baru beli lagi.', 
              likes: '184',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget Fungsi Pembentuk Kartu Komentar (Reusable Komponen)
  Widget _buildCommentCard({
    required String name, 
    required String date, 
    required String comment, 
    required String likes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // Menggunakan warna border soft orange khas tema UI aplikasi kamu
        border: Border.all(color: const Color(0xFFFFE1D6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Atas: Profil Pengulas & Rating Bintang Kecil
          Row(
            children: [
              const CircleAvatar(
                radius: 15, 
                backgroundColor: AppColors.lightGrey, 
                child: Icon(Icons.person, size: 16, color: AppColors.textGrey),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textBlack),
                  ),
                  Text(
                    date, 
                    style: const TextStyle(color: AppColors.textGrey, fontSize: 10),
                  ),
                ],
              ),
              const Spacer(),
              // Mini Bintang Pengulas
              Row(
                children: List.generate(
                  5, 
                  (index) => const Icon(Icons.star, color: Colors.amber, size: 13),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          
          // Isi Teks Komentar Reviewer
          Text(
            comment,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF4A4A4A),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          
          // Baris Bawah: Fitur Likes Komentar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.thumb_up_rounded, size: 13, color: AppColors.primaryOrange),
              const SizedBox(width: 5),
              Text(
                '$likes Liked',
                style: const TextStyle(fontSize: 11, color: AppColors.textGrey, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}