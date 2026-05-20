import 'package:flutter/material.dart';
// Sesuaikan dengan path file proyek Anda
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/models/category_model.dart';
import 'package:fixnow/views/detail_layanan_view.dart';
import 'package:fixnow/models/technician_model.dart';

class CategoryDetailView extends StatefulWidget {
  const CategoryDetailView({Key? key}) : super(key: key);

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  String _selectedTab = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Semua Layanan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. FILTER SEARCH COMPONENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFFF7A3D).withOpacity(0.4)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Elektronik',
                  hintStyle: TextStyle(color: Color(0xFFFF7A3D)),
                  suffixIcon: Icon(Icons.search, color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          // 2. HORIZONTAL SCROLL TAB CHIPS
          const SizedBox(height: 10),
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildTabChip('Semua'),
                _buildTabChip('Electronic'),
                _buildTabChip('Cleaning'),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. GRID CONTENT VIA FUTUREBUILDER
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              // Sesuai perintah: ApiService().getCategories()
              // future: ApiService().getCategories(),
              future: Future.delayed(const Duration(seconds: 1), () => [
                {'name': 'Service AC', 'price': '100K', 'rating': 4.9, 'img': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?w=300'},
                {'name': 'Service Elektronik', 'price': '100K', 'rating': 4.9, 'img': 'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=300'},
                {'name': 'Service Listrik', 'price': '100K', 'rating': 4.9, 'img': 'https://images.unsplash.com/photo-1621905252507-b354bc25edac?w=300'},
                {'name': 'Cleaning Service', 'price': '100K', 'rating': 4.9, 'img': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=300'},
                {'name': 'Service Kendaraan', 'price': '300K', 'rating': 4.8, 'img': 'https://images.unsplash.com/photo-1486006920555-c77dce18193b?w=300'},
                {'name': 'Service Furniture', 'price': '80K', 'rating': 4.7, 'img': 'https://images.unsplash.com/photo-1540518614846-7eded433c457?w=300'},
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFFF6232)));
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Gagal mengambil data layanan'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Layanan tidak tersedia'));
                }

                final items = snapshot.data!;
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.82,
                  ),
                  itemBuilder: (context, index) {
                    final service = items[index];
                    return GestureDetector(
                      onTap: () {
                        // Jalankan navigasi saat card diklik
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailLayananView()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7F4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFFE5DA), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Component
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(19),
                                  topRight: Radius.circular(19),
                                ),
                                child: Image.network(
                                  service['img'],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Info Text Group
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service['name'] ?? '',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Mulai dari ${service['price']}',
                                    style: const TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 14),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${service['rating']}',
                                        style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for custom chips tab
  Widget _buildTabChip(String label) {
    bool isSelected = _selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = label),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF7A3D) : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}