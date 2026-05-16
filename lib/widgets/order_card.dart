import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class OrderCard extends StatelessWidget {
  final String serviceName;
  final String status;
  final Color statusColor;
  final String techName;
  final double techRating;
  final String dateTime;
  final String imagePath;
  final String actionButtonText;
  final VoidCallback onActionPressed;
  final bool chatButtonEnabled;

  const OrderCard({
    super.key,
    required this.serviceName,
    required this.status,
    required this.statusColor,
    required this.techName,
    required this.techRating,
    required this.dateTime,
    required this.imagePath,
    required this.actionButtonText,
    required this.onActionPressed,
    this.chatButtonEnabled = false, required Null Function() onChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.build_circle_outlined, color: AppColors.primaryOrange, size: 18),
                  const SizedBox(width: 6),
                  Text(serviceName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textBlack)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: AppColors.lightGrey, thickness: 1),
          ),
          Row(
            children: [
              CircleAvatar(radius: 18, backgroundColor: AppColors.lightGrey, backgroundImage: AssetImage(imagePath)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(techName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textBlack)),
                      const SizedBox(width: 6),
                      Text(techRating.toString(), style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
                      const Icon(Icons.star, color: Colors.orange, size: 12),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(dateTime, style: const TextStyle(color: AppColors.textGrey, fontSize: 10)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (chatButtonEnabled) ...[
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryOrange),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Chat', style: TextStyle(color: AppColors.primaryOrange, fontSize: 12)),
                ),
                const SizedBox(width: 8),
              ],
              ElevatedButton(
                onPressed: onActionPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(actionButtonText, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}