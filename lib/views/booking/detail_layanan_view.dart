import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/views/total_ulasan_view.dart'; 
import 'package:fixnow/views/booking/select_technician_view.dart';

class DetailLayananView extends StatefulWidget {
  final String serviceName;
  final String serviceImage;

  const DetailLayananView({
    super.key,
    required this.serviceName,
    required this.serviceImage,
  });

  @override
  State<DetailLayananView> createState() => _DetailLayananViewState();
}

class _DetailLayananViewState extends State<DetailLayananView> {
  bool _isLoading = false;

  Widget _buildCoverImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => const ContainerFallback());
    }
    return Image.asset(path, fit: BoxFit.cover, errorBuilder: (c, e, s) => const ContainerFallback());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  color: AppColors.lightGrey,
                  child: _buildCoverImage(widget.serviceImage), 
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.arrow_back, color: AppColors.textBlack, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: const Color(0xFFFFF0EB), borderRadius: BorderRadius.circular(6)),
                        child: const Text('★ 4.9', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primaryOrange)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(color: const Color(0xFFE6F9EE), borderRadius: BorderRadius.circular(6)),
                        child: const Text('✓ Terverifikasi', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.successGreen)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Tentang Layanan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                  const SizedBox(height: 6),
                  const Text(
                    'Service AC meliputi pembersihan filter, evaporator, dan pengecekan freon. Teknisi berpengalaman minimal 3 tahun.',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.lightGrey))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mulai dari', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                Text('Rp 120k / unit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // KUNCI JALUR 1: Detail -> Pilih Teknisi
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SelectTechnicianView()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryOrange,
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Pesan Sekarang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerFallback extends StatelessWidget {
  const ContainerFallback({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF0EB),
      child: const Center(child: Icon(Icons.build_circle_rounded, size: 64, color: AppColors.primaryOrange)),
    );
  }
}