import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../widgets/order_card.dart';
import '../widgets/review_dialog.dart';
import 'live_tracking_view.dart'; // <-- Import halaman Lacak
import 'isi_chat_view.dart';      // <-- Import halaman Isi Chat

class HistoryPemesananView extends StatefulWidget {
  const HistoryPemesananView({super.key});

  @override
  State<HistoryPemesananView> createState() => _HistoryPemesananViewState();
}

class _HistoryPemesananViewState extends State<HistoryPemesananView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('Orderku', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textGrey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(color: AppColors.primaryOrange, borderRadius: BorderRadius.circular(10)),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Aktif'),
                Tab(text: 'Selesai'),
                Tab(text: 'Dibatalkan'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB AKTIF
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              OrderCard(
                serviceName: 'Service AC Split',
                status: 'Dalam Proses',
                statusColor: Colors.amber[700]!,
                techName: 'Ahmad Tohari',
                techRating: 4.8,
                dateTime: 'Rabu, 12 Maret 2026 - 10:00',
                imagePath: 'assets/images/ahmad_tohari.png',
                actionButtonText: 'Lacak',
                chatButtonEnabled: true,
                // KETIKA TOMBOL LACAK DIKLIK
                onActionPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LiveTrackingView()),
                  );
                },
                // KETIKA TOMBOL CHAT DI KARTU DIKLIK
                onChatPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IsiChatView(
                        name: 'Ahmad Tohari',
                        role: 'Teknisi AC',
                        imgPath: 'assets/images/ahmad_tohari.png',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          // TAB SELESAI
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              OrderCard(
                serviceName: 'Service AC Split',
                status: 'Selesai',
                statusColor: AppColors.successGreen,
                techName: 'Ahmad Tohari',
                techRating: 4.8,
                dateTime: 'Rabu, 12 Maret 2026 - 10:00',
                imagePath: 'assets/images/ahmad_tohari.png',
                actionButtonText: 'Beri Ulasan',
                onActionPressed: () {
                  showDialog(context: context, builder: (_) => const ReviewDialog());
                }, onChatPressed: () {  },
              ),
            ],
          ),
          const Center(child: Text('Belum ada pesanan dibatalkan')),
        ],
      ),
    );
  }
}