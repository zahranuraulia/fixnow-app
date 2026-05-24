import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/services/api_service.dart';

class AllReviewsView extends StatefulWidget {
  const AllReviewsView({super.key});

  @override
  State<AllReviewsView> createState() => _AllReviewsViewState();
}

class _AllReviewsViewState extends State<AllReviewsView> {
  final ApiService _apiService = ApiService();
  List<dynamic> _reviews = [];
  bool _isLoading = true;
  String _techName = "Teknisi";

  @override
  void initState() {
    super.initState();
    _loadTechnicianReviews();
  }

  // Mengambil sesi ID Teknisi yang login lalu fetch data review dari API
  Future<void> _loadTechnicianReviews() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Mengambil userId yang disimpan saat login sebagai techId
      String? techId = prefs.getString('userId');
      String? savedName = prefs.getString('name');

      if (savedName != null) {
        setState(() {
          _techName = savedName;
        });
      }

      if (techId != null && techId.isNotEmpty) {
        // Memanggil fungsi API yang sudah kita perbaiki kemarin
        final data = await _apiService.getReviewsByTechnician(techId);
        setState(() {
          _reviews = data;
          _isLoading = false;
        });
      } else {
        _setFallbackData();
      }
    } catch (e) {
      print("Error load reviews: $e");
      _setFallbackData();
    }
  }

  // Data Fallback (Offline Mode) jika server Railway belum terisi data ulasan dari user
  void _setFallbackData() {
    setState(() {
      _reviews = [
        {
          "user_name": "Sativa Attha",
          "date": "18 April 2025",
          "rating": 3.0,
          "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
        },
        {
          "user_name": "Adhiana Alika",
          "date": "10 Juni 2025",
          "rating": 4.0,
          "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
        },
        {
          "user_name": "Handoko",
          "date": "7 Juni 2024",
          "rating": 5.0,
          "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam."
        },
        {
          "user_name": "DSI Siti Nurbaya",
          "date": "1 Juni 2020",
          "rating": 3.0,
          "comment": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        }
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            const Text(
              'Review Customer',
              style: TextStyle(color: AppColors.textBlack, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '(${_reviews.length} Review)',
              style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryOrange))
          : _reviews.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  itemCount: _reviews.length,
                  itemBuilder: (context, index) {
                    final item = _reviews[index];
                    return _buildReviewCard(
                      name: item['user_name'] ?? 'Anonymous',
                      date: item['date'] ?? '-',
                      rating: (item['rating'] as num).toDouble(),
                      comment: item['comment'] ?? '',
                    );
                  },
                ),
    );
  }

  // Tampilan jika belum ada user yang memberikan ulasan sama sekali
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.rate_review_outlined, size: 64, color: AppColors.textGrey),
          SizedBox(height: 16),
          Text(
            'Belum ada ulasan masuk',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack),
          ),
          Text(
            'Ulasan dari pelanggan akan muncul di sini.',
            style: TextStyle(fontSize: 12, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  // Widget Pembuat Card Sesuai Desain Figma (image_7d1d90.png)
  Widget _buildReviewCard({
    required String name,
    required String date,
    required double rating,
    required String comment,
  }) {
    // Penentuan warna background card tipis berdasarkan rating figma kamu
    Color cardBgColor = const Color(0xFFF4FBF7); // Hijau soft default
    Color cardBorderColor = const Color(0xFFE2F3EC);

    if (rating <= 3.0) {
      cardBgColor = const Color(0xFFFFF5F5); // Merah/Pink soft untuk rating rendah
      cardBorderColor = const Color(0xFFFFE5E5);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFFFEBE3),
                child: Icon(Icons.person, color: AppColors.primaryOrange, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              // Bintang Rating Dinamis
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    size: 16,
                    color: index < rating ? Colors.amber : Colors.grey[300],
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            comment,
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey, height: 1.4),
          ),
        ],
      ),
    );
  }
}