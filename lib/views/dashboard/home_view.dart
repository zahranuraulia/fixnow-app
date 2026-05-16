import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // PERBAIKAN: Mencegah keyboard merusak posisi Floating Bottom Nav Bar
      resizeToAvoidBottomInset: false, 
      body: Stack(
        children: [
          // Main Content Layer (Scrollable)
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderSection(),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        StatusInfoCard(),
                        SizedBox(height: 20),
                        PromoBannerSlider(),
                        SizedBox(height: 24),
                        CategorySection(),
                        SizedBox(height: 24),
                        ExpertTechnicianSection(),
                        SizedBox(height: 24),
                        ConsultationCTA(),
                        // Spacer agar konten paling bawah tidak tertutup oleh Bottom Navigation Bar
                        SizedBox(height: 110),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Floating Bottom Navigation Bar Layer
          const Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// 1. HEADER SECTION (Orange Gradient, Search Bar & Profile)
// =========================================================================
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B2C), Color(0xFFFF8A3D)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Atas: Nama & Tombol Aksi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // PERBAIKAN: Menghapus 'const' di level Row untuk menghindari konflik render emoji
                    children: const [
                      Text(
                        'Selamat Pagi ',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      Text('☁️', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Zahra Aulia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // Tombol Notifikasi
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        const Icon(Icons.notifications, color: Colors.white, size: 22),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Avatar Profil
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFE0E0E0),
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),
          // Search Bar
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.4), width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Cari Layanan perbaikan...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// =========================================================================
// 2. STATUS INFO CARD (Kotak Hitam Status Perbaikan)
// =========================================================================
class StatusInfoCard extends StatelessWidget {
  const StatusInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D24),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.electric_bolt_outlined, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Perbaikan listrik korslet',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  'Estimasi 21 menit lagi sampai',
                  style: TextStyle(color: Colors.grey[400], fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10),
          )
        ],
      ),
    );
  }
}

// =========================================================================
// 3. PROMO BANNER (Banner Diskon & Slider Indicator)
// =========================================================================
class PromoBannerSlider extends StatelessWidget {
  const PromoBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7A45),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Promo Hari Ini',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Diskon 30%\nCleaning AC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFFF7A45),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Ambil Promo ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Icon(Icons.arrow_forward, size: 14),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFFF5403),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                shape: BoxShape.circle,
              ),
            ),
          ],
        )
      ],
    );
  }
}

// =========================================================================
// 4. CATEGORY SECTION (Scrollable Horizontal Menu)
// =========================================================================
class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Menambahkan icon tiruan agar UI tidak kosong melompong
    final List<Map<String, dynamic>> categories = [
      {'name': 'rumah', 'icon': Icons.build_outlined, 'isActive': true},
      {'name': 'kendaraan', 'icon': Icons.directions_car_outlined, 'isActive': false},
      {'name': 'listrik', 'icon': Icons.bolt, 'isActive': false},
      {'name': 'furniture', 'icon': Icons.chair_outlined, 'isActive': false},
      {'name': 'elektronik', 'icon': Icons.tv_rounded, 'isActive': false},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kategori Layanan',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2F3542)),
        ),
        const SizedBox(height: 14),
        // PERBAIKAN: Menggunakan SingleChildScrollView agar kategori tidak jebol (overflow) saat dibuka di layar kecil
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: categories.map((cat) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0), // Beri jarak antar elemen
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: cat['isActive'] ? Colors.white : const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(12),
                        border: cat['isActive']
                            ? Border.all(color: const Color(0xFFFF7A45), width: 1.5)
                            : null,
                      ),
                      child: Icon(
                        cat['icon'], 
                        color: cat['isActive'] ? const Color(0xFFFF5403) : const Color(0xFF2F3542), 
                        size: 24
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat['name'],
                      style: TextStyle(
                        fontSize: 11,
                        color: cat['isActive'] ? const Color(0xFFFF5403) : Colors.grey[600],
                        fontWeight: cat['isActive'] ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

// =========================================================================
// 5. TECHNICIAN SECTION (List Daftar Teknisi Berpengalaman)
// =========================================================================
class ExpertTechnicianSection extends StatelessWidget {
  const ExpertTechnicianSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> technicians = [
      {
        'name': 'Parasha Amalia',
        'expert': 'Cleaning Service',
        'expertColor': const Color(0xFFFF5403),
        'desc': 'Sangat berpengalaman melayani pelanggan retail maupun korporat...',
        'rating': '5.0',
        'experience': '5 Tahun',
        'instansi': 'Yayasan Kasih'
      },
      {
        'name': 'Talitha Aurely',
        'expert': 'Service Oven',
        'expertColor': const Color(0xFF2ED573),
        'desc': 'Teknisi ahli elektronik dapur dan perbaikan oven tersertifikasi...',
        'rating': '5.0',
        'experience': '5 Tahun',
        'instansi': 'PT Marvirst'
      }
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Teknisi berpengalaman',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2F3542)),
        ),
        const SizedBox(height: 12),
        Column(
          children: technicians.map((tech) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F2F6), width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF2F3542),
                    child: Text(
                      tech['name'].substring(0, 2).toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: tech['name'] + ' | ',
                            style: const TextStyle(
                              color: Color(0xFF2F3542),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            children: [
                              TextSpan(
                                text: tech['expert'],
                                style: TextStyle(
                                  color: tech['expertColor'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tech['desc'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600], fontSize: 11),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFFB800), size: 14),
                            const SizedBox(width: 2),
                            Text(
                              tech['rating'],
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2F3542)),
                            ),
                            const SizedBox(width: 8),
                            Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Text(
                              tech['experience'],
                              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                            ),
                            const SizedBox(width: 8),
                            Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                tech['instansi'],
                                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(minimumSize: Size.zero, padding: const EdgeInsets.symmetric(vertical: 4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Lihat lebih banyak ',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 14),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// =========================================================================
// 6. CONSULTATION CTA (Banner Pertanyaan & Konsultasi)
// =========================================================================
class ConsultationCTA extends StatelessWidget {
  const ConsultationCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9F43), Color(0xFFFF7A45)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            'Ada Pertanyaan?',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
              children: const [
                TextSpan(text: 'Yuk, '),
                TextSpan(text: 'Konsultasi', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' langsung dengan kami!'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFFF7A45),
              minimumSize: const Size(double.infinity, 44),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              'Chat Sekarang',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

// =========================================================================
// 7. CUSTOM BOTTOM NAVIGATION BAR (Floating & Rounded)
// =========================================================================
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5403),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.home_filled, color: Colors.white, size: 22),
          ),
          const Icon(Icons.assignment_outlined, color: Color(0x9957606F), size: 24),
          const Icon(Icons.chat_bubble_outline, color: Color(0x9957606F), size: 24),
          const Icon(Icons.receipt_long_outlined, color: Color(0x9957606F), size: 24),
          const Icon(Icons.person_outline, color: Color(0x9957606F), size: 24),
        ],
      ),
    );
  }
}