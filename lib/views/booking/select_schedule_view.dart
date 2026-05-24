import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class SelectScheduleView extends StatefulWidget {
  final Map<String, dynamic>? technicianData;

  const SelectScheduleView({super.key, this.technicianData});

  @override
  State<SelectScheduleView> createState() => _SelectScheduleViewState();
}

class _SelectScheduleViewState extends State<SelectScheduleView> {
  int selectedDay = 9; // Default tanggal 9 sesuai Figma kamu
  String selectedTime = '10:00';

  @override
  Widget build(BuildContext context) {
    final currentTech =
        widget.technicianData ??
        {
          'name': 'Ahmad Tohari',
          'rating': '4.8',
          'role': 'Service AC Split',
          'price': 120000,
        };

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Jadwal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {},
                ),
                const Text(
                  'Maret 2026',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Header Hari Kalender
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Min', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Sen', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Sel', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Rab', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Kam', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Jum', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text('Sab', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            // Grid Angka Kalender
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 31,
              itemBuilder: (context, index) {
                int day = index + 1;
                bool isSelected = day == selectedDay;
                // Highlight khusus tanggal 8 samar-samar sesuai Figma kamu
                bool isSpecialDay = day == 8;

                return GestureDetector(
                  onTap: () => setState(() => selectedDay = day),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryOrange
                          : (isSpecialDay
                                ? const Color(0xFFFFF0EB)
                                : Colors.transparent),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isSpecialDay
                                    ? AppColors.primaryOrange
                                    : Colors.black),
                          fontWeight: (isSelected || isSpecialDay)
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Waktu kedatangan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  [
                    '08:00',
                    '09:00',
                    '10:00',
                    '11:00',
                    '13:00',
                    '14:00',
                    '15:00',
                    '16:00',
                    '17:00',
                  ].map((time) {
                    bool isSelected = time == selectedTime;
                    return GestureDetector(
                      onTap: () => setState(() => selectedTime = time),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 72) / 3,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryOrange
                              : const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryOrange
                                : const Color(0xFFEFEFEF),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            time,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/order_summary',
                    arguments: {
                      'technicianData': currentTech,
                      'selectedDay': selectedDay,
                      'selectedTime': selectedTime,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Lanjutkan ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
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
