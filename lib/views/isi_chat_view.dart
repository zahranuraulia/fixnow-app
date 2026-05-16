import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'call_view.dart';

class IsiChatView extends StatelessWidget {
  final String name;
  final String role;
  final String imgPath;

  const IsiChatView({super.key, required this.name, required this.role, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: AppColors.lightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(radius: 16, backgroundImage: AssetImage(imgPath)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                Text(role, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_outlined, color: AppColors.textBlack),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CallView(name: name, role: role, imgPath: imgPath)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Area Isi Pesan-pesan Chat
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                    child: const Text('Yesterday', style: TextStyle(color: AppColors.textGrey, fontSize: 11)),
                  ),
                ),
                const SizedBox(height: 20),
                _buildBubbleChat('Permisi kak untuk Jasa Cleaning Servisnya hari ini apakah masih tersedia?', false),
                _buildBubbleChat('Mohon maaf kak saat baru ini sudah full', true),
              ],
            ),
          ),
          
          // Input Box Pesan Bawah & Tombol DONE Sesuai Gambar Figma
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.lightGrey)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('DONE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.image_outlined, color: AppColors.textGrey), onPressed: () {}),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(20)),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter Your Message...',
                            hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(icon: const Icon(Icons.mic_none, color: AppColors.primaryOrange), onPressed: () {}),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBubbleChat(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryOrange : const Color(0xFFFFF0EB),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: isMe ? Colors.white : AppColors.textBlack, fontSize: 13, height: 1.4),
        ),
      ),
    );
  }
}