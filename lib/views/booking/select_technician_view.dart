import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/views/booking/select_schedule_view.dart';

class SelectTechnicianView extends StatefulWidget {
  const SelectTechnicianView({super.key});

  @override
  State<SelectTechnicianView> createState() => _SelectTechnicianViewState();
}

class _SelectTechnicianViewState extends State<SelectTechnicianView> {
  // Menyimpan indeks teknisi yang sedang dipilih (Default teknisi pertama)
  int selectedIndex = 0;

  final List<Map<String, dynamic>> technicians = [
    {
      'name': 'Ahmad Tohari',
      'rating': '4.8',
      'experience': '4 Tahun',
      'distance': '1.5 Km',
      'role': 'Service AC Split',
      'price': 120000,
      'image': 'https://images.unsplash.com/photo-1540569014015-19a7be504e3a?w=150'
    },
    {
      'name': 'Fauzan Engkol',
      'rating': '4.7',
      'experience': '1 Tahun',
      'distance': '3.4 Km',
      'role': 'Service AC Inverter',
      'price': 120000,
      'image': 'https://images.unsplash.com/photo-1566492031773-4f4e44671857?w=150'
    },
    {
      'name': 'Bram e rame',
      'rating': '4.9',
      'experience': '10 Tahun',
      'distance': '11 Km',
      'role': 'Service AC Central',
      'price': 120000,
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150'
    },
  ];

  @override
  Widget build(BuildContext context) {
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
              'Pilih Teknisi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text(
              'Teknisi terdekat di area kamu',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: technicians.length,
                itemBuilder: (context, index) {
                  final tech = technicians[index];
                  bool isSelected = index == selectedIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryOrange : const Color(0xFFEFEFEF),
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              tech['image'],
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tech['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${tech['rating']} • ${tech['experience']} • ${tech['distance']}',
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Custom Radio Button Oranye Sesuai Figma
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppColors.primaryOrange : Colors.grey.shade300,
                                width: isSelected ? 6 : 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectScheduleView(
                        technicianData: technicians[selectedIndex],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}