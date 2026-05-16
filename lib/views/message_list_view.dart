import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'isi_chat_view.dart'; // <-- Pastikan import ini ada untuk membuka halaman chat

class MessageListView extends StatelessWidget {
  const MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search Conversation',
                  hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: AppColors.textGrey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          // Kategori Tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildTag('Semua', true),
                const SizedBox(width: 8),
                _buildTag('On Progress', false),
                const SizedBox(width: 8),
                _buildTag('Done', false),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // Label Last Message
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Last message', style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w500)),
          ),
          
          // Daftar Chat Item
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                // Mengirimkan BuildContext agar fungsi Navigator di bawah bisa berjalan
                _buildChatItem(context, 'Heri', 'Apakah AC-nya sudah dingin?', '15 Min ago', 'assets/images/ahmad_tohari.png', 'Service AC'),
                _buildChatItem(context, 'Susan', 'Halo mas saya sudah selesai', '1 hour ago', 'assets/images/susan_susanti.png', 'Cleaning Service'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryOrange : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(fontSize: 13, color: isActive ? Colors.white : AppColors.textBlack, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
    );
  }

  // Menambahkan BuildContext context di parameter agar fungsi pindah halaman aktif
  Widget _buildChatItem(BuildContext context, String name, String msg, String time, String imgPath, String role) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 24, 
            backgroundColor: AppColors.lightGrey,
            // Jika kamu belum punya aset foto, kamu bisa menggantinya dengan Icon sementara:
            // child: const Icon(Icons.person, color: AppColors.textGrey),
          ),
          title: Text('$name | $role', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
          subtitle: Text(msg, style: const TextStyle(fontSize: 12, color: AppColors.textGrey), maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          
          // ==========================================
          // SAMBUNGAN UTAMA: COBA CEK BAGIAN INI KEMBALI
          // ==========================================
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IsiChatView(
                  name: name,
                  role: role,
                  imgPath: imgPath,
                ),
              ),
            );
          },
          // ==========================================
        ),
        const Divider(color: AppColors.lightGrey, thickness: 1),
      ],
    );
  }
}