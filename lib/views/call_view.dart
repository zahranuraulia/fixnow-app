import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CallView extends StatelessWidget {
  final String name;
  final String role;
  final String imgPath;

  const CallView({super.key, required this.name, required this.role, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            const Spacer(),
            
            // Nama & Info
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
            const SizedBox(height: 5),
            Text('$role Service', style: const TextStyle(fontSize: 18, color: AppColors.primaryOrange, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            const Text('Calling...', style: TextStyle(color: AppColors.textGrey, fontSize: 14)),
            const SizedBox(height: 40),
            
            // Avatar Utama Bulat Besar Sesuai Gambar 4
            CircleAvatar(
              radius: 90,
              backgroundColor: AppColors.lightGrey,
              backgroundImage: AssetImage(imgPath),
            ),
            
            const Spacer(),
            
            // Bar Navigasi Aksi Panggilan Bawah (Kamera, Speaker, Mic, Tutup)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(icon: const Icon(Icons.videocam_outlined, color: AppColors.textBlack), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.volume_up_outlined, color: AppColors.textBlack), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.mic_none, color: AppColors.textBlack), onPressed: () {}),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 22,
                    child: IconButton(
                      icon: const Icon(Icons.call_end, color: Colors.white, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}