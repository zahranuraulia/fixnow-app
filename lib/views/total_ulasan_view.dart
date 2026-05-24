import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class TotalUlasanView extends StatelessWidget {
  final String technicianId;
  final String technicianName;

  const TotalUlasanView({
    super.key,
    required this.technicianId,
    required this.technicianName,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reviews = [
      {'name': 'Satria Artha', 'date': '14 April 2026', 'rating': 3, 'color': const Color(0xFFFFF0F0)},
      {'name': 'Adhiana Alika', 'date': '10 Juni 2025', 'rating': 4, 'color': const Color(0xFFF0FFF5)},
      {'name': 'Handoko', 'date': '7 Juni 2024', 'rating': 5, 'color': const Color(0xFFF0FFF5)},
      {'name': 'Dwi Siti Nurbaya', 'date': '1 Juli 2023', 'rating': 2, 'color': const Color(0xFFFFF0F0)},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF5F5F5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Column(
          children: [
            Text('Review Customer', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            Text('(345 Review)', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final item = reviews[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item['color'],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.primaryOrange,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(item['date'], style: const TextStyle(color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          Icons.star,
                          color: starIndex < item['rating'] ? Colors.amber : Colors.grey[300],
                          size: 18,
                        );
                      }),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}