import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Beri Ulasan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Service AC Split - #FN2026031201', style: TextStyle(fontSize: 11, color: AppColors.textGrey)),
            const SizedBox(height: 15),
            
            // Avatar Foto Teknisi
            const CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.lightGrey,
              child: Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 10),
            const Text('Ahmad Tohari', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const Text('Teknisi AC - Berpengalaman 3 tahun', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
            const SizedBox(height: 15),

            // Bintang Rating yang bisa diklik
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => const Icon(Icons.star_border, color: Colors.amber, size: 28)),
            ),
            const SizedBox(height: 8),
            const Text('Tap bintang untuk memberi nilai', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
            const SizedBox(height: 15),

            // Tags Kategori Suka
            Wrap(
              spacing: 8,
              children: [
                _buildChip('Tepat Waktu'),
                _buildChip('Professional'),
                _buildChip('Ramah'),
              ],
            ),
            const SizedBox(height: 15),

            // Input Catatan/Komentar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
              child: const TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Teknisi sangat profesional dan tepat waktu...',
                  hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 12),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Kirim Kirim Oranye Bulat Kanan Bawah sesuai figma
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: AppColors.primaryOrange,
                radius: 20,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 16),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.primaryOrange)),
      backgroundColor: const Color(0xFFFFF0EB),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}