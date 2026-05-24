import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class TechCardHorizontal extends StatelessWidget {
  final String name;
  final double rating;
  final String experience; 
  final String distance;
  final bool isSelected;
  final VoidCallback onTap;
  final String? avatarUrl; // 👈 TAMBAHKAN INI AGAR FOTO BISA DIKIRIM DARI API

  const TechCardHorizontal({
    super.key,
    required this.name,
    required this.rating,
    required this.experience, 
    required this.distance,
    required this.isSelected,
    required this.onTap,
    this.avatarUrl, // Opsional, kalau kosong otomatis pakai link Unsplash online
  });

  @override
  Widget build(BuildContext context) {
    // 🛠️ FIX: Hilangkan ahmad_tohari.png lokal. Gunakan URL dinamis/online fallback.
    String finalAvatarUrl = (avatarUrl != null && avatarUrl!.startsWith('http'))
        ? avatarUrl!
        : 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'; // Fallback online gratis wajah profesional

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : const Color(0xFFE5E5E5),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar bulat murni Network Image online
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFEBE3),
                image: DecorationImage(
                  image: NetworkImage(finalAvatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGrey,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('•', style: TextStyle(color: AppColors.textGrey)),
                      const SizedBox(width: 6),
                      Text(
                        experience.contains('Tahun') ? experience : '$experience Tahun',
                        style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                      ),
                      const SizedBox(width: 6),
                      const Text('•', style: TextStyle(color: AppColors.textGrey)),
                      const SizedBox(width: 6),
                      Text(
                        distance,
                        style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primaryOrange : const Color(0xFFCCCCCC),
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}