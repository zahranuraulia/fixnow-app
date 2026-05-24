import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class OrderSummaryView extends StatelessWidget {
  final Map<String, dynamic> technicianData;
  final int selectedDate;
  final String selectedTime;

  const OrderSummaryView({
    super.key,
    required this.technicianData,
    required this.selectedDate,
    required this.selectedTime,
  });

  String _formatRupiah(int number) {
    return 'Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final String techName = technicianData['name'] ?? 'Ahmad Tohari';
    // Perbaikan error toDouble() aman di sini dengan konversi toString() langsung
    final String techRating = technicianData['rating']?.toString() ?? '4.8';
    final String serviceRole = technicianData['role'] ?? 'Service AC Split';
    
    final int hargaLayanan = technicianData['price'] is int ? technicianData['price'] : 120000;
    const int biayaPerjalanan = 10000;
    const int diskonPromo = 36000;
    final int totalAkhir = (hargaLayanan + biayaPerjalanan) - diskonPromo;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 24),
            
            // Card Indah Bermodelkan List Isian Figma
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEFEFEF)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row Judul Layanan + Icon Kunci Inggris/Setting
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.build_rounded, color: Colors.grey, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(serviceRole, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          const Text('1 unit', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Detail Isian Baris demi Baris
                  _buildDetailRow('Teknisi', '$techName  ★ $techRating'),
                  _buildDetailRow('Jadwal', 'Rab, $selectedDate Maret | $selectedTime'),
                  _buildDetailRow('Lokasi', 'Jl Bratan V, G5 H1'),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFEFEFEF), thickness: 1),
                  ),
                  
                  _buildDetailRow('Harga Layanan', _formatRupiah(hargaLayanan)),
                  _buildDetailRow('Biaya perjalanan', _formatRupiah(biayaPerjalanan)),
                  _buildDetailRow('Diskon promo', '- ${_formatRupiah(diskonPromo)}', isDiscount: true),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFEFEFEF), thickness: 1),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(
                        _formatRupiah(totalAkhir),
                        style: const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, 
                    '/payment_method',
                    arguments: {
                      'technicianData': technicianData,
                      'selectedDay': selectedDate,
                      'selectedTime': selectedTime,
                    }
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Lanjutkan ke Pembayaran', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isDiscount ? const Color(0xFF27AE60) : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}