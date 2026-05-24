import 'package:fixnow/views/booking/detail_layanan_view.dart';
import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy produk/layanan sesuai desain mockup kamu
    final List<Map<String, String>> services = [
      {
        'title': 'Service AC',
        'price': 'Mulai dari 100K',
        'rating': '4.9',
        'image': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?q=80&w=500',
      },
      {
        'title': 'Service Elektronik',
        'price': 'Mulai dari 100K',
        'rating': '4.9',
        'image': 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?q=80&w=500',
      },
      {
        'title': 'Service Listrik',
        'price': 'Mulai dari 100K',
        'rating': '4.9',
        'image': 'https://images.unsplash.com/photo-1621905251918-48416bd8575a?q=80&w=500',
      },
      {
        'title': 'Cleaning Service',
        'price': 'Mulai dari 100K',
        'rating': '4.9',
        'image': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?q=80&w=500',
      },
      {
        'title': 'Service Kendaraan',
        'price': 'Mulai dari 300K',
        'rating': '4.8',
        'image': 'https://images.unsplash.com/photo-1486006920555-c77dce18193b?q=80&w=500',
      },
      {
        'title': 'Service Furniture',
        'price': 'Mulai dari 60K',
        'rating': '4.7',
        'image': 'https://images.unsplash.com/photo-1540518614846-7eded433c457?q=80&w=500',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Semua Layanan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Layanan
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Layanan...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Filter Chips Kategori
            Row(
              children: [
                _buildFilterChip('Semua', true),
                const SizedBox(width: 8),
                _buildFilterChip('Electronic', false),
                const SizedBox(width: 8),
                _buildFilterChip('Cleaning', false),
              ],
            ),
            const SizedBox(height: 16),

            // Grid Produk Layanan
            Expanded(
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = services[index];
                  
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailLayananView(
                            serviceName: item['title'] ?? 'Nama Layanan',
                            serviceImage: item['image'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF6F2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar Layanan
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                item['image']!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          // Detail Teks
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['price']!,
                                  style: const TextStyle(color: Color(0xFFFF7A3D), fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      item['rating']!,
                                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF7A3D) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}