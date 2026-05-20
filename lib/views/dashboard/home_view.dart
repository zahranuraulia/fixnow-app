import 'package:flutter/material.dart';
// Sesuaikan dengan path file proyek Anda
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/models/category_model.dart';
import 'package:fixnow/models/technician_model.dart';
import 'package:fixnow/models/user_model.dart';
import 'package:fixnow/views/dashboard/category_detail_view.dart';

class HomeView extends StatefulWidget {
  final String? userName; // Menerima nama user dari halaman login jika ada

  const HomeView({Key? key, this.userName}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    String dispName = widget.userName ?? "Zahra Aulia";

    // PERBAIKAN: Mendaftarkan halaman ke dalam List sesuai urutan item navbar
    // Index 0: Konten Utama Home, Index 1: Halaman Kategori
    final List<Widget> _pages = [
      HomeContent(dispName: dispName), // <--- Widget konten utama dipisah ke bawah
      const CategoryDetailView(),      // <--- Halaman Category yang kamu kirim
      const Center(child: Text('Halaman Chat')),
      const Center(child: Text('Halaman History')),
      const Center(child: Text('Halaman Profile')),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      
      // PERBAIKAN: Body berubah dinamis mengikuti navbar yang aktif
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      
      // BOTTOM NAVIGATION FLOATING ALIGNED WITH FIGMA
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, spreadRadius: 2, offset: const Offset(0, -2))
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          // PERBAIKAN: Fungsi setState untuk memicu perubahan halaman saat di-tap
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFFF6232),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Booking'), // Ini tombol Kategori kamu
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// WIDGET KONTEN UTAMA HOME (Pindahan dari body lama agar navbar tidak hilang)
// =========================================================================
class HomeContent extends StatelessWidget {
  final String dispName;

  const HomeContent({Key? key, required this.dispName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER GRADIENT SECTION
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF8E53), Color(0xFFFF6232)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('Selamat Pagi ', style: TextStyle(color: Colors.white, fontSize: 14)),
                              Icon(Icons.wb_sunny, color: Colors.amber, size: 16),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dispName,
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
                                onPressed: () {},
                              ),
                              Positioned(
                                right: 12,
                                top: 12,
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                                ),
                              )
                            ],
                          ),
                          const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white30,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Cari Layanan perbaikan...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. PROMO BANNER DISKON ACCORDING TO FIGMA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7A3D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text('Promo Hari Ini', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Diskon 30%\nCleaning AC',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFFF7A3D),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('Ambil Promo ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Icon(Icons.add, size: 16),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 3. SERVICE CATEGORIES (DYNAMIC VIA FUTUREBUILDER)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Kategori Layanan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('Lihat Semua', style: TextStyle(color: Color(0xFFFF7A3D), fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 90,
              child: FutureBuilder<List<dynamic>>(
                future: Future.delayed(const Duration(seconds: 1), () => [
                  {'id': 1, 'name': 'Rumah', 'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2544/2544087.png'},
                  {'id': 2, 'name': 'Kendaraan', 'imageUrl': 'https://cdn-icons-png.flaticon.com/512/743/743854.png'},
                  {'id': 3, 'name': 'Elektronik', 'imageUrl': 'https://cdn-icons-png.flaticon.com/512/3659/3659899.png'},
                  {'id': 4, 'name': 'Furniture', 'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2415/2415292.png'},
                ]), 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFFFF6232)));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Gagal memuat kategori'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Tidak ada kategori'));
                  }

                  final categories = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 75,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF6F2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: const Color(0xFFFFB394), width: index == 0 ? 1 : 0),
                                ),
                                child: Image.network(cat['imageUrl'] ?? '', height: 30, width: 30, fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat['name'] ?? '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11, 
                                  fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                                  color: index == 0 ? const Color(0xFFFF6232) : Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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

            const SizedBox(height: 20),

            // 4. EXPERIENCED TECHNICIANS (DYNAMIC VIA FUTUREBUILDER)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text('Teknisi berpengalaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            
            FutureBuilder<List<dynamic>>(
              future: Future.delayed(const Duration(seconds: 1), () => [
                {'name': 'Parasha Amalia', 'skill': 'Cleaning Service', 'rating': 5.0, 'exp': '5 Tahun', 'vendor': 'Yayasan Kasih', 'img': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150'},
                {'name': 'Talitha Aurely', 'skill': 'Service Oven', 'rating': 2.0, 'exp': '3 Tahun', 'vendor': 'PT Marwataf', 'img': 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150'},
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator(color: Color(0xFFFF6232))),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Gagal memuat daftar teknisi'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada teknisi aktif'));
                }

                final technicians = snapshot.data!;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: technicians.length,
                  itemBuilder: (context, index) {
                    final tech = technicians[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDFB),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xFFFFE0D3), width: 1),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(tech['img'], height: 60, width: 60, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Colors.black, fontSize: 13),
                                    children: [
                                      TextSpan(text: '${tech['name']} | ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: tech['skill'], style: const TextStyle(color: Color(0xFFFF6232), fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    const SizedBox(width: 3),
                                    Text('${tech['rating']} • ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    Text('${tech['exp']} • ', style: const TextStyle(fontSize: 12)),
                                    Text(tech['vendor'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 100), // Ruang ekstra agar konten tidak tertutup floating navbar
          ],
        ),
      ),
    );
  }
}