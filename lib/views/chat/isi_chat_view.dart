import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/views/call_view.dart';
import 'package:fixnow/views/beri_ulasan_view.dart';

class IsiChatView extends StatefulWidget {
  final String name;
  final String role;
  final String imgPath;

  const IsiChatView({
    super.key,
    required this.name,
    required this.role,
    required this.imgPath,
  });

  @override
  State<IsiChatView> createState() => _IsiChatViewState();
}

class _IsiChatViewState extends State<IsiChatView> {
  final ApiService _apiService = ApiService();
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add({
      'text': 'Halo kak! Ada yang bisa saya bantu untuk pengerjaan hari ini?',
      'isMe': false,
      'isImage': false,
    });
  }

  ImageProvider _getAvatarProvider(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return NetworkImage(path);
    }
    return const NetworkImage(
      'https://images.unsplash.com/photo-1581092921461-eab62e97a780?w=150',
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isMe': true, 'isImage': false});
      _messageController.clear();
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text':
                'Baik kak, mohon tunggu sebentar ya. Saya cek jadwal pesanan terlebih dahulu.',
            'isMe': false,
            'isImage': false,
          });
        });
      }
    });
  }

  void _sendImageMock() {
    setState(() {
      _messages.add({
        'text':
            'https://images.unsplash.com/photo-1581092921461-eab62e97a780?w=500',
        'isMe': true,
        'isImage': true,
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'Foto pekerjaan sudah saya terima kak. Segera diproses ya.',
            'isMe': false,
            'isImage': false,
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[200],
              backgroundImage: _getAvatarProvider(widget.imgPath),
              onBackgroundImageError: (exception, stackTrace) {
                debugPrint("Gagal memuat network avatar.");
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.role,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone_outlined, color: AppColors.textBlack),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CallView(
                    name: widget.name,
                    role: widget.role,
                    imgPath: widget.imgPath,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final chat = _messages[index];
                return _buildBubbleChat(
                  chat['text'],
                  chat['isMe'],
                  chat['isImage'] ?? false,
                );
              },
            ),
          ),
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
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String orderKey =
                        'status_done_${widget.name.trim().toLowerCase()}';
                    await prefs.setBool(orderKey, true);

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Status pesanan berhasil diubah menjadi Selesai!',
                        ),
                      ),
                    );

                    // 🛠️ PERBAIKAN UTAMA: Menggunakan pushReplacement untuk memutus loop navigasi hancur (.then ditendang!)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BeriUlasanView(
                          serviceName: widget.name,
                          orderId: widget.role,
                          technicianName: widget.imgPath,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'DONE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.image_outlined,
                        color: AppColors.textGrey,
                      ),
                      onPressed: _sendImageMock,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: _messageController,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Message...',
                            hintStyle: TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(
                        Icons.send_rounded,
                        color: AppColors.primaryOrange,
                      ),
                      onPressed: _sendMessage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubbleChat(String message, bool isMe, bool isImage) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: isImage ? const EdgeInsets.all(6) : const EdgeInsets.all(14),
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
        child: isImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  message,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) {
                    return const Icon(Icons.broken_image, size: 50);
                  },
                ),
              )
            : Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : AppColors.textBlack,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
      ),
    );
  }
}
