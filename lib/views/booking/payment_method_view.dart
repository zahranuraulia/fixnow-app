import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class PaymentMethodView extends StatelessWidget {
  final Map<String, dynamic> technicianData;
  final int selectedDate; // DISINKRONKAN DENGAN MAIN.DART
  final String selectedTime; // DISINKRONKAN DENGAN MAIN.DART

  const PaymentMethodView({
    super.key,
    required this.technicianData,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Metode Pembayaran', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Metode Pembayaran', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.wallet, color: AppColors.primaryOrange),
              title: const Text('Transfer Bank (Otomatis)'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/success_booking');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.money, color: AppColors.primaryOrange),
              title: const Text('Bayar di Tempat (COD)'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/success_booking');
              },
            ),
          ],
        ),
      ),
    );
  }
}