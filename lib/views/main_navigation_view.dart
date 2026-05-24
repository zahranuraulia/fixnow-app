import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/views/dashboard/home_view.dart';
import 'package:fixnow/views/dashboard/category_detail_view.dart'; // Halaman Semua Layanan / Produk kamu
import 'package:fixnow/views/chat/message_list_view.dart';          // Halaman Chat kamu
import 'package:fixnow/views/activity/history_pemesanan_view.dart';  // Halaman History kamu
import 'package:fixnow/views/profile/user_profile_view.dart';        // Halaman Profil User kamu

class MainNavigationView extends StatefulWidget {
  final int initialIndex; // Parameter untuk menentukan tab awal saat halaman ini dipanggil ulang

  const MainNavigationView({
    super.key,
    this.initialIndex = 0, // Default ke angka 0 (Beranda Utama) jika tidak diisi
  });

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _selectedIndex = 0;

  // Susunan 5 halaman asli milikmu tanpa merubah isinya
  final List<Widget> _views = [
    const HomeView(),                  // Tab 1: Beranda Utama (Indeks 0)
    const CategoryDetailView(),        // Tab 2: Semua Layanan / Produk (Indeks 1)
    const MessageListView(),           // Tab 3: Chat / Pesan (Indeks 2)
    const HistoryPemesananView(),      // Tab 4: Riwayat Aktivitas (Indeks 3)
    const UserProfileView(),           // Tab 5: Profil Pelanggan (Indeks 4)
  ];

  @override
  void initState() {
    super.initState();
    // Set indeks awal saat widget pertama kali dibuat
    _selectedIndex = widget.initialIndex;
  }

  // 🛠️ PERBAIKAN UTAMA: Memastikan tab langsung berpindah jika dipanggil ulang dari halaman Checkout / Ulasan
  @override
  void didUpdateWidget(covariant MainNavigationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      setState(() {
        _selectedIndex = widget.initialIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _views,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.lightGrey, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryOrange,
          unselectedItemColor: AppColors.textGrey,
          showSelectedLabels: false,   // Menyembunyikan teks label sesuai mockup
          showUnselectedLabels: false, // Menyembunyikan teks label saat tidak aktif
          items: const [
            // Tab 1: Home
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), 
              activeIcon: Icon(Icons.home), 
              label: '',
            ),
            // Tab 2: Semua Layanan (Produk)
            BottomNavigationBarItem(
              icon: Icon(Icons.business_center_outlined), 
              activeIcon: Icon(Icons.business_center), 
              label: '',
            ),
            // Tab 3: Chat
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), 
              activeIcon: Icon(Icons.chat_bubble), 
              label: '',
            ),
            // Tab 4: History
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined), 
              activeIcon: Icon(Icons.assignment), 
              label: '',
            ),
            // Tab 5: Profile
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), 
              activeIcon: Icon(Icons.person), 
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}