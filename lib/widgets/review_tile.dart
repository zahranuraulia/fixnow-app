import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class ReviewTile extends StatelessWidget {
  final String name;
  final double rating;
  final String date;
  final String comment;
  final String userImageUrl;

  const ReviewTile({
    super.key,
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
    this.userImageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFEFEF)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Atas: Foto Profil, Nama, Tanggal, dan Rating Star
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFFFEFEA),
                backgroundImage: userImageUrl.isNotEmpty 
                    ? AssetImage(userImageUrl) as ImageProvider
                    : null,
                child: userImageUrl.isEmpty
                    ? const Icon(Icons.person, color: AppColors.primaryOrange, size: 20)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              // Badge Rating Kecil ala Figma
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9E6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFF2C94C), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Bagian Bawah: Isi Ulasan Komentar Customer
          Text(
            comment,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textBlack,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}