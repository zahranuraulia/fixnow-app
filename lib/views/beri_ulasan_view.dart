import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class BeriUlasanView extends StatefulWidget {
  final String serviceName;
  final String orderId;
  final String technicianName;

  const BeriUlasanView({
    super.key,
    this.serviceName = 'Service AC Split',
    this.orderId = '#FN2026031201',
    this.technicianName = 'Ahmad Tohari',
  });

  @override
  State<BeriUlasanView> createState() => _BeriUlasanViewState();
}

class _BeriUlasanViewState extends State<BeriUlasanView> {
  int _selectedRating = 5;
  final TextEditingController _reviewController = TextEditingController(
    text: 'Teknisi sangat profesional dan tepat waktu. Hasil servis sangat memuaskan!',
  );

  // List tag opsi ulasan seperti di screenshot
  final List<Map<String, dynamic>> _tags = [
    {'text': 'Tepat Waktu', 'isSelected': true},
    {'text': 'Professional', 'isSelected': true},
    {'text': 'Ramah', 'isSelected': true},
    {'text': 'Rapi & Bersih', 'isSelected': false},
    {'text': 'Harga Wajar', 'isSelected': false},
  ];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF5F5F3),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Beri Ulasan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.serviceName} - ${widget.orderId}',
              style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
            ),
            const SizedBox(height: 24),

            // Foto Teknisi Bulat
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200'), // Fallback foto
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nama & Detail Teknisi
            Text(
              widget.technicianName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text(
              'Teknisi AC - Berpengalaman 3 tahun',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
            const SizedBox(height: 16),

            // Bintang Rating interaktif
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _selectedRating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: Colors.amber,
                    size: 36,
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap bintang untuk memberi nilai',
              style: TextStyle(fontSize: 11, color: AppColors.textGrey),
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColors.lightGrey),
            const SizedBox(height: 16),

            // Bagian "Apa yang kamu suka?"
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Apa yang kamu suka?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 12),

            // Bungkus Kumpulan Tag Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags.map((tag) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      tag['isSelected'] = !tag['isSelected'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: tag['isSelected'] ? const Color(0xFFFFF0EB) : const Color(0xFFF5F5F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tag['text'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: tag['isSelected'] ? AppColors.primaryOrange : AppColors.textGrey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Kolom Catatan Ulasan + Tombol Kirim Pesawat Kertas (Mirip Screenshot)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _reviewController,
                      maxLines: null,
                      style: const TextStyle(fontSize: 12, color: Colors.black87),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tulis ulasan Anda di sini...',
                        hintStyle: TextStyle(fontSize: 12, color: AppColors.textGrey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // 🛠️ TOMBOL PESAWAT KERTAS SAKTI (DENGAN NAVIGASI AMAN)
                  GestureDetector(
                    onTap: () {
                      // 1. Munculin info sukses singkat
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ulasan berhasil disimpan!'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ),
                      );

                      // 2. KUNCI UTAMA: Cukup pop biar langsung balik halaman aktif/history!
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}