import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class MembershipView extends StatelessWidget {
  const MembershipView({super.key});

  @override
  Widget build(BuildContext context) {
    // Data list paket membership sesuai mockup figma kamu
    final List<Map<String, dynamic>> membershipPlans = [
      {
        'title': 'Gold',
        'price': 'Rp. 350.000',
        'color': const [Color(0xFFFCD34D), Color(0xFFF59E0B)], // Gradasi Emas
        'benefits': [
          'Diskon 10-30%',
          'Layanan Prioritas Utama (Fast-Track)',
          'Garansi Pekerjaan 30 hari',
          'Handyman Terpilih (Grade A+)',
          'Gratis Konsultasi & Estimasi',
        ],
      },
      {
        'title': 'Silver',
        'price': 'Rp. 250.000',
        'color': const [Color(0xFFE5E7EB), Color(0xFF9CA3AF)], // Gradasi Silver
        'benefits': [
          'Diskon 5-10%',
          'Prioritas Antrian',
          'Gratis Biaya Survey',
          'Garansi Pekerjaaan 14 Hari',
        ],
      },
      {
        'title': 'Bronze',
        'price': 'Rp. 150.000',
        'color': const [Color(0xFFED8936), Color(0xFFDD6B20)], // Gradasi Bronze
        'benefits': [
          'Diskon 5%',
          'Biaya Transaksi Ringan',
          'Estimasi Waktu Akurat',
          'Garansi Standar 7 Hari',
        ],
      },
    ];

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
          'Membership',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Text(
                'Membership berlaku selama 3 bulan',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              
              // Loop daftar paket membership
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: membershipPlans.length,
                itemBuilder: (context, index) {
                  final plan = membershipPlans[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Bagian Header Kartu (Bergradasi sesuai tingkatannya)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: plan['color'],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          child: Center(
                            child: Text(
                              plan['title'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                        
                        // Bagian Daftar Benefit
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Mengenerate poin benefit ke bawah
                              ...(plan['benefits'] as List<String>).map((benefit) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                      Expanded(
                                        child: Text(
                                          benefit,
                                          style: const TextStyle(fontSize: 13, color: Colors.black87),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              
                              const SizedBox(height: 16),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 8),
                              
                              // Bagian Harga dan Tombol Checkout
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    plan['price'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Logika ketika customer menekan tombol checkout paket
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Menuju halaman pembayaran ${plan['title']}...')),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    ),
                                    child: const Text(
                                      'Check out now',
                                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}