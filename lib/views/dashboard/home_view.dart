import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/models/technician_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Setup untuk Banner Auto-Scroll
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _bannerTimer;

  // Tempat menampung data teknisi
  List<TechnicianModel> _technicians = [];

  // DAFTAR PATH FOTO PROMO DARI ASSET
  final List<String> _promoImages = [
    'assets/diskon 1.jpeg',
    'assets/diskon 2.jpeg',
    'assets/diskon 3.jpeg',
  ];

  @override
  void initState() {
    super.initState();

    // Langsung panggil data teknisi dari server tanpa nunggu loading screen
    _fetchTechnicians();

    // Timer Promo Banner
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _promoImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  // Fungsi ambil data dari server Railway
  Future<void> _fetchTechnicians() async {
    try {
      final data = await ApiService().getTechnicians();
      if (mounted && data.isNotEmpty) {
        setState(() {
          _technicians = data;
        });
      }
    } catch (e) {
      // Jika server offline / HP ga ada internet, pakai data fallback biar ga kosong melompong
      if (mounted) {
        setState(() {
          _technicians = [
            TechnicianModel(
              id: '1',
              name: 'Ahmad Tohari',
              specialization: 'Listrik',
              rating: 4.9,
              experience: '5 Tahun',
              description: 'Ahli pasang AC dan instalasi listrik rumahan.',
              imageUrl: '',
              price: 150000,
            ),
            TechnicianModel(
              id: '2',
              name: 'Budi Setiawan',
              specialization: 'Pipa & Air',
              rating: 4.7,
              experience: '3 Tahun',
              description: 'Mengatasi saluran mampet dan wastafel bocor.',
              imageUrl: '',
              price: 120000,
            ),
          ];
        });
      }
    }
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP BANNER GRADIENT
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                left: 24,
                right: 24,
                bottom: 28,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF27024), Color(0xFFFF9A5C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Pagi ⛅',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
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
                          IconButton(
                            icon: const Icon(
                              Icons.notifications_none_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () {},
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white24,
                            child: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Cari Layanan perbaikan...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. KOTAK HITAM STATUS PEMESANAN
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/tracking_service');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E2A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.electrical_services_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Perbaikan listrik konslet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Teknisi 2 menit lagi sampai',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Sedang Berlangsung',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. PROMO BANNER AUTO-SCROLL
                  const Text(
                    'Promo Hari Ini',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _promoImages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              _promoImages[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Text('Foto Promo Tidak Ditemukan'),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Indikator Titik Banner
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_promoImages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 6,
                        width: _currentPage == index ? 16 : 6,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primaryOrange
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),

                  // 3. SEKSI DAFTAR TEKNISI LANGSUNG
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Teknisi Berpengalaman',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Lihat lebih banyak >',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 🛠️ DAFTAR TEKNISI LANGSUNG JALAN TANPA TUNGGU LOADING SCREEN
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _technicians.length,
                    itemBuilder: (context, index) {
                      final tech = _technicians[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _buildTechnicianCard(
                          context,
                          name: tech.name.toString().isEmpty
                              ? 'Tanpa Nama'
                              : tech.name,
                          skill: tech.specialization.toString().isEmpty
                              ? 'Generalist'
                              : tech.specialization,
                          rating: tech.rating != null
                              ? tech.rating.toString()
                              : '5.0',
                          exp: tech.experience.toString().isEmpty
                              ? '1 Tahun'
                              : tech.experience,
                          vendor: tech.vendor ?? 'FixNow Partner',
                          desc: tech.description.toString().isEmpty
                              ? '-'
                              : tech.description,
                          imageUrl: tech.imageUrl ?? '',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  // 4. BANNER KONSULTASI / CHAT BOT
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDE3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Ada Pertanyaan?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Yuk, Konsultasi langsung dengan kami!',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textGrey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: AppColors.primaryOrange,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/bot_chat');
                            },
                            child: const Text(
                              'Chat Sekarang',
                              style: TextStyle(
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicianCard(
    BuildContext context, {
    required String name,
    required String skill,
    required String rating,
    required String exp,
    required String vendor,
    required String desc,
    required String imageUrl,
  }) {
    Widget imageWidget;
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.person, size: 32, color: Colors.grey),
      );
    } else if (imageUrl.isNotEmpty && imageUrl.contains('assets/')) {
      imageWidget = Image.asset(
        imageUrl,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.person, size: 32, color: Colors.grey),
      );
    } else {
      imageWidget = const Icon(Icons.person, size: 32, color: Colors.grey);
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/technician_detail');
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFFFEDE3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(26),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: imageWidget,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '| $skill',
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '• $exp • $vendor',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
  }
}
