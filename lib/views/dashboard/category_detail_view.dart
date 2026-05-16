// category_detail_view.dart
import 'package:flutter/material.dart';

class CategoryDetailView extends StatefulWidget {
  const CategoryDetailView({Key? key}) : super(key: key);

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  // Data dummy untuk Filter Chips
  final List<String> _filters = ['Semua', 'Electronic', 'Cleaning', 'Vehicle', 'Furniture'];
  int _selectedFilterIndex = 0;

  // Data dummy untuk Daftar Layanan
  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Service AC',
      'price': 'Mulai dari 100K',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?q=80&w=500',
    },
    {
      'title': 'Service Elektronik',
      'price': 'Mulai dari 100K',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?q=80&w=500',
    },
    {
      'title': 'Service Listrik',
      'price': 'Mulai dari 100K',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1621905252507-b354bc25edac?q=80&w=500',
    },
    {
      'title': 'Cleaning Service',
      'price': 'Mulai dari 100K',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?q=80&w=500',
    },
    {
      'title': 'Service Kendaraan',
      'price': 'Mulai dari 300K',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1486006920555-c77dce18193b?q=80&w=500',
    },
    {
      'title': 'Service Furniture',
      'price': 'Mulai dari 80K',
      'rating': '4.9',
      'imageUrl': 'https://images.unsplash.com/photo-1540518614846-7eded433c457?q=80&w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFFF7A45);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Konten Utama (Scrollable)
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  // 1. Header Title dengan Tombol Kembali (Back Button)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
                          onPressed: () => Navigator.pop(context), // Kembali ke HomeView
                        ),
                        const Expanded(
                          child: Text(
                            'Semua Layanan',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Elektronik',
                        hintStyle: const TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        suffixIcon: const Icon(Icons.search, color: Colors.black54),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3. Filter Kategori (Horizontal Scroll)
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filters.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedFilterIndex == index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedFilterIndex = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : const Color(0xFFF0F0F0),
                                borderRadius: BorderRadius.circular(24),
                                border: isSelected 
                                    ? null 
                                    : Border.all(color: Colors.grey.shade300, width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  _filters[index],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.grey.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 4. Daftar Layanan (Grid View 2 Kolom)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double itemWidth = constraints.maxWidth / 2;
                        final double itemHeight = itemWidth * 1.25; 
                        
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _services.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: itemWidth / itemHeight,
                          ),
                          itemBuilder: (context, index) {
                            final service = _services[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF5F0), 
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Foto Ilustrasi
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          service['imageUrl']!,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: Colors.grey.shade200,
                                              child: const Center(
                                                child: SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(strokeWidth: 2, color: primaryColor),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Informasi Text
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service['title']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          service['price']!,
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              service['rating']!,
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 5. Custom Bottom Navigation Bar Floating
            Positioned(
              bottom: 16,
              left: 20,
              right: 20,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Tombol Home: Saat ditekan akan pop (kembali) ke HomeView
                    IconButton(
                      icon: const Icon(Icons.home_outlined, color: Colors.grey, size: 28),
                      onPressed: () => Navigator.pop(context), 
                    ),
                    // Item Aktif (Layanan / Koper) berbentuk lingkaran oranye penuh
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.business_center, color: Colors.white, size: 24),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 24),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.assignment_outlined, color: Colors.grey, size: 24),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_outline, color: Colors.grey, size: 26),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}