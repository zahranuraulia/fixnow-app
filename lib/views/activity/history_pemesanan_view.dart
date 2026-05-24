import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/widgets/order_card.dart';
import 'package:fixnow/widgets/review_dialog.dart';
import 'package:fixnow/views/live_tracking_view.dart'; 
import 'package:fixnow/views/chat/isi_chat_view.dart';      

class HistoryPemesananView extends StatefulWidget {
  const HistoryPemesananView({super.key});

  @override
  State<HistoryPemesananView> createState() => _HistoryPemesananViewState();
}

class _HistoryPemesananViewState extends State<HistoryPemesananView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiService _apiService = ApiService();
  
  List<dynamic> _allOrders = [];
  bool _isLoading = true;
  String _myRole = 'user';
  String _myId = '';
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchSessionAndOrders();
  }

  Future<void> _fetchSessionAndOrders() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      _prefs = await SharedPreferences.getInstance();
      
      // Mengamankan session ID dan Role agar tidak kosong setelah kena pushAndRemoveUntil
      _myRole = _prefs?.getString('role') ?? 'user';
      _myId = _prefs?.getString('userId') ?? '';

      debugPrint("DEBUG HISTORY: Memuat data untuk Role -> $_myRole, ID -> $_myId");

      // Mengambil data dari API Railway
      final data = await _apiService.getOrders();
      debugPrint("DEBUG HISTORY: Total data mentah dari API -> ${data.length} item");
      
      if (mounted) {
        setState(() {
          _allOrders = data; 
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('DEBUG HISTORY ERROR: Gagal load data history karena -> $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _allOrders = []; // Fallback aman biar UI gak ngeblank merah
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<dynamic> _filterOrdersByStatus(String tabStatus) {
    if (_allOrders.isEmpty) return [];

    return _allOrders.where((order) {
      if (order == null) return false;

      String databaseStatus = '';
      
      // PENGAMANAN TIPE DATA: Bisa membaca Map JSON mentah maupun Class Object Model sekaligus
      if (order is Map) {
        databaseStatus = (order['status'] ?? '').toString().toLowerCase();
      } else {
        try {
          databaseStatus = (order.status ?? '').toString().toLowerCase();
        } catch (_) {
          databaseStatus = '';
        }
      }

      // Filter super fleksibel menyesuaikan perubahan status pasca ulasan dikirim
      if (tabStatus == 'Aktif') {
        return databaseStatus == 'dalam proses' || 
               databaseStatus == 'pending' || 
               databaseStatus == 'ongoing' || 
               databaseStatus == 'active' ||
               databaseStatus == ''; // Jaga-jaga kalau status null dari API biar tetep muncul di tab pertama
      } else if (tabStatus == 'Selesai') {
        return databaseStatus == 'selesai' || 
               databaseStatus == 'done' || 
               databaseStatus == 'success';
      } else {
        return databaseStatus == 'dibatalkan' || 
               databaseStatus == 'canceled' || 
               databaseStatus == 'failed';
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Riwayat Pesanan',
          style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryOrange,
          unselectedLabelColor: AppColors.textGrey,
          indicatorColor: AppColors.primaryOrange,
          tabs: const [
            Tab(text: 'Aktif'),
            Tab(text: 'Selesai'),
            Tab(text: 'Dibatalkan'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryOrange))
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList('Aktif'),
                _buildOrderList('Selesai'),
                _buildOrderList('Dibatalkan'),
              ],
            ),
    );
  }

  Widget _buildOrderList(String tabStatus) {
    final filteredList = _filterOrdersByStatus(tabStatus);

    if (filteredList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Belum ada pesanan $tabStatus', 
              style: const TextStyle(color: AppColors.textGrey, fontSize: 14)
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _fetchSessionAndOrders,
              child: const Text('Refresh Data', style: TextStyle(color: AppColors.primaryOrange)),
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchSessionAndOrders,
      color: AppColors.primaryOrange,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final order = filteredList[index];
          
          // Deklarasi variabel penampung data dinamis aman
          String serviceTitle = 'Jasa Perbaikan';
          String orderStatus = 'Pending';
          String orderTime = 'Hari ini';
          String apiNetworkImage = 'https://images.unsplash.com/photo-1581092921461-eab62e97a780?w=300'; // Default online fallback
          String techName = 'Teknisi FixNow';

          // Ekstraksi data fleksibel (mencegah error NoSuchMethodError di model ataupun map)
          if (order is Map) {
            serviceTitle = order['serviceName'] ?? order['service_name'] ?? 'Jasa Perbaikan';
            orderStatus = order['status'] ?? 'Pending';
            orderTime = order['date'] ?? order['created_at'] ?? 'Hari ini';
            var img = order['imageUrl'] ?? order['image_url'] ?? order['image'];
            if (img != null && img.toString().isNotEmpty) apiNetworkImage = img.toString();
            if (order['technician'] != null && order['technician']['name'] != null) {
              techName = order['technician']['name'];
            }
          } else {
            // Jika bertipe Model Object (OrderModel)
            try { serviceTitle = order.serviceName ?? 'Jasa Perbaikan'; } catch (_) {}
            try { orderStatus = order.status ?? 'Pending'; } catch (_) {}
            try { orderTime = order.date ?? 'Hari ini'; } catch (_) {}
            try {
              var img = (order as dynamic).imageUrl ?? (order as dynamic).image;
              if (img != null && img.toString().isNotEmpty) apiNetworkImage = img.toString();
            } catch (_) {}
            try { techName = (order as dynamic).technicianName ?? 'Teknisi FixNow'; } catch (_) {}
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: OrderCard(
              serviceName: serviceTitle,
              status: orderStatus,
              statusColor: tabStatus == 'Aktif' 
                  ? Colors.amber[700]! 
                  : tabStatus == 'Selesai' ? AppColors.successGreen : Colors.red,
              techName: techName,
              techRating: 4.8,
              dateTime: orderTime,
              imagePath: apiNetworkImage, // 👈 100% Menggunakan URL API Network / Online Fallback
              actionButtonText: tabStatus == 'Aktif' 
                  ? (_myRole == 'technician' ? 'Selesaikan Kerja' : 'Lacak') 
                  : 'Beri Ulasan',
              chatButtonEnabled: true,
              onActionPressed: () {
                if (tabStatus == 'Aktif') {
                  if (_myRole == 'technician') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Memproses penyelesaian order...'))
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveTrackingView(
                          serviceName: serviceTitle, 
                          techName: techName,
                          orderStatus: orderStatus,
                        ),
                      ),
                    );
                  }
                } else if (tabStatus == 'Selesai') {
                  showDialog(context: context, builder: (_) => const ReviewDialog());
                }
              },
              onChatPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IsiChatView(
                      name: techName,
                      role: 'Penyedia Layanan',
                      imgPath: apiNetworkImage, 
                    ),
                  ),
                ).then((_) {
                  _fetchSessionAndOrders();
                });
              },
            ),
          );
        },
      ),
    );
  }
}