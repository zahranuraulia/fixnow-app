import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
// 🛠️ PASTIKAN IMPORT FILE NAVIGASI UTAMA (YANG ADA NAVBAR-NYA) DI SINI:
// Contoh: import 'package:fixnow/views/main_navigation_view.dart';
import 'package:fixnow/views/dashboard/home_view.dart';
import 'package:fixnow/views/live_tracking_view.dart'; 

class SuccessBookingView extends StatelessWidget {
  final Map<String, dynamic> technicianData;
  final int selectedDay;
  final String selectedTime;

  const SuccessBookingView({
    super.key,
    required this.technicianData,
    required this.selectedDay,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    final String techName = technicianData['name'] ?? 'Teknisi';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    '🎉', 
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Pesanan Berhasil!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Teknisi akan segera mengkonfirmasi dan\nmenuju lokasi kamu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEFEA),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  '#FN2026031201',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildRowDetail('Layanan', 'Service AC Split'),
                    const SizedBox(height: 14),
                    _buildRowDetail('Teknisi', techName),
                    const SizedBox(height: 14),
                    _buildRowDetail('Jadwal', 'Rab, $selectedDay Maret | $selectedTime'),
                    const SizedBox(height: 14),
                    _buildRowDetail('Dibayar', 'Rp. 94.000', isPrice: true),
                  ],
                ),
              ),
              
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LiveTrackingView(
                          serviceName: 'Service AC Split', 
                          techName: 'Ahmad Tohari', 
                          orderStatus: 'On Progress',
                        ), 
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Pantau Pesanan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 🛠️ FIX NAVBAR HILANG: Membakar tumpukan page lama dan mengembalikan susunan Navbar Induk
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    // Taruh nama class penampung BottomNavigationBar kamu di sini (misal: MainNavigationView)
                    // Sementara diarahkan ke HomeView bawaan kamu agar aplikasi aman dari crash
                    MaterialPageRoute(builder: (context) => const HomeView()), 
                    (route) => false,
                  );
                },
                child: const Text(
                  'Kembali ke Home',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowDetail(String label, String value, {bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
        ),
        Text(
          value,
          style: TextStyle(
            color: isPrice ? const Color(0xFF27AE60) : AppColors.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}