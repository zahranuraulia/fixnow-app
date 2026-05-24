import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/views/chat/isi_chat_view.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({super.key});

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  String _myRole = 'user';
  String _myId = '';
  
  List<Map<String, dynamic>> _chatConversations = [];
  String _activeTag = 'Semua';

  @override
  void initState() {
    super.initState();
    _loadSessionAndChats();
  }

  /// Memuat session dan mendeteksi status chat secara real-time berdasarkan tracking ID lokal
  Future<void> _loadSessionAndChats() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      _myRole = prefs.getString('role') ?? 'user';
      _myId = prefs.getString('userId') ?? '';

      final technicians = await _apiService.getTechnicians();
      List<Map<String, dynamic>> loadedChats = [];

      if (_myRole == 'technician') {
        // JIKA LOGIN SEBAGAI TEKNISI: Mendeteksi status order dari customer
        for (var customerId in ['u101', 'u102']) {
          bool isDone = prefs.getBool('status_done_$customerId') ?? false;
          
          if (customerId == 'u101') {
            loadedChats.add({
              'id': 'u101',
              'name': 'Zahra Aulia',
              'subName': 'Customer - Laundry Room',
              'lastMsg': 'Permisi mas, untuk pengerjaan jam 2 siang bisa?',
              'time': '5 mnt lalu',
              'status': isDone ? 'Done' : 'On Progress',
              'imageUrl': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
            });
          } else {
            loadedChats.add({
              'id': 'u102',
              'name': 'Rian Perkasa',
              'subName': 'Customer - Perbaikan AC',
              'lastMsg': 'Oke mas, terima kasih jasanya ya!',
              'time': '2 jam lalu',
              'status': isDone ? 'Done' : 'Done', // Simulasi bawaan done
              'imageUrl': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
            });
          }
        }
      } else {
        // JIKA LOGIN SEBAGAI USER BIASA: Menarik data Teknisi asli dari API Railway
        for (var tech in technicians) {
          final String techId = tech.id ?? '';
          
          // 🛠️ SINKRONISASI LOGIKA DI SINI: Cek apakah ID teknisi ini sudah diselesaikan di history
          bool isDone = prefs.getBool('status_done_$techId') ?? false;
          String currentStatus = isDone ? 'Done' : 'On Progress';

          loadedChats.add({
            'id': techId,
            'name': tech.name ?? 'Teknisi FixNow',
            'subName': tech.specialization ?? 'Teknisi FixNow',
            'lastMsg': 'Halo kak, ada yang bisa saya bantu hari ini?', 
            'time': '15 mnt lalu',
            'status': currentStatus, 
            'imageUrl': tech.imageUrl ?? '', 
          });
        }
      }

      if (mounted) {
        setState(() {
          _chatConversations = loadedChats;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error mengoper data chat: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<Map<String, dynamic>> _getFilteredChats() {
    if (_activeTag == 'Semua') {
      return _chatConversations;
    }
    return _chatConversations.where((chat) {
      final status = chat['status']?.toString().trim().toLowerCase() ?? '';
      final targetTag = _activeTag.trim().toLowerCase();
      return status == targetTag;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredChats = _getFilteredChats();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Message', 
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textBlack)
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
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
                _buildTag('Semua'),
                const SizedBox(width: 8),
                _buildTag('On Progress'),
                const SizedBox(width: 8),
                _buildTag('Done'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Last message', 
              style: TextStyle(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w500)
            ),
          ),
          
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.primaryOrange))
                : filteredChats.isEmpty
                    ? const Center(
                        child: Text(
                          'Tidak ada percakapan', 
                          style: TextStyle(color: AppColors.textGrey, fontSize: 13)
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadSessionAndChats,
                        color: AppColors.primaryOrange,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          itemCount: filteredChats.length,
                          itemBuilder: (context, index) {
                            final chat = filteredChats[index];
                            return _buildChatItem(
                              context,
                              id: chat['id'] ?? '',
                              name: chat['name'] ?? 'No Name',
                              msg: chat['lastMsg'] ?? '',
                              time: chat['time'] ?? '',
                              role: chat['subName'] ?? '',
                              imageUrl: chat['imageUrl'] ?? '', 
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    bool isActive = _activeTag == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTag = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryOrange : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text, 
          style: TextStyle(
            fontSize: 13, 
            color: isActive ? Colors.white : AppColors.textBlack, 
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context, {
    required String id,
    required String name, 
    required String msg, 
    required String time, 
    required String imageUrl, 
    required String role
  }) {
    Widget imageWidget;
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey, size: 28),
      );
    } else {
      String fallbackUrl = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'; // Susan / Zahra
      if (name.toLowerCase().contains('ahmad') || name.toLowerCase().contains('budi') || name.toLowerCase().contains('rian')) {
        fallbackUrl = 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150'; // Ahmad / Budi
      }
      imageWidget = Image.network(
        fallbackUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.grey, size: 28),
      );
    }

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: imageWidget,
            ),
          ),
          title: Text(
            '$name | $role', 
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            msg, 
            style: const TextStyle(fontSize: 12, color: AppColors.textGrey), 
            maxLines: 1, 
            overflow: TextOverflow.ellipsis
          ),
          trailing: Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IsiChatView(
                  name: name,
                  role: role,
                  imgPath: imageUrl.isNotEmpty ? imageUrl : 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150',
                ),
              ),
            );
          },
        ),
        const Divider(color: AppColors.lightGrey, thickness: 1),
      ],
    );
  }
}