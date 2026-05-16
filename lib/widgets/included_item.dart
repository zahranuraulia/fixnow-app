import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class IncludedItem extends StatelessWidget {
  final String text;
  const IncludedItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: AppColors.primaryOrange, size: 18),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: AppColors.textBlack, fontSize: 14)),
        ],
      ),
    );
  }
}