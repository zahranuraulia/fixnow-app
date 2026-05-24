import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class BotChatView extends StatefulWidget {
  const BotChatView({super.key});

  @override
  State<BotChatView> createState() => _BotChatViewState();
}

class _BotChatViewState extends State<BotChatView> {
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Halo! Selamat datang di Layanan Bantuan FixNow Bot 🤖. Ada yang bisa kami bantu mengenai kendala perbaikan Anda?',
      'isMe': false
    }
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    
    final userText = _controller.text;
    setState(() {
      _messages.add({'text': userText, 'isMe': true});
    });
    _controller.clear();

    // Simulasi Bot membalas otomatis setelah 1 detik
    Future.delayed(const Duration(seconds: 1), () {
      String botResponse = 'Terima kasih atas laporannya. Tim teknisi kami akan segera memverifikasi keluhan Anda terkait "$userText".';
      if (userText.toLowerCase().contains('ac')) {
        botResponse = 'Kendala AC kurang dingin atau bocor biasanya memerlukan cuci AC berkala. Anda bisa langsung memesan paket Cleaning AC di dashboard utama!';
      } else if (userText.toLowerCase().contains('harga') || userText.toLowerCase().contains('biaya')) {
        botResponse = 'Seluruh rincian tarif transparan kami dapat Anda lihat secara langsung sebelum mengonfirmasi pesanan di aplikasi.';
      }
      
      setState(() {
        _messages.add({'text': botResponse, 'isMe': false});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryOrange,
              child: Icon(Icons.smart_toy_rounded, color: Colors.white),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FixNow Assistant', style: TextStyle(color: AppColors.textBlack, fontSize: 15, fontWeight: FontWeight.bold)),
                Text('Online Bot', style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: msg['isMe'] ? AppColors.primaryOrange : const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: Radius.circular(msg['isMe'] ? 12 : 0),
                        bottomRight: Radius.circular(msg['isMe'] ? 0 : 12),
                      ),
                    ),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: Text(
                      msg['text'],
                      style: TextStyle(color: msg['isMe'] ? Colors.white : AppColors.textBlack, fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFEFEFEF)))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Tulis pesan konsultasi...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      fillColor: const Color(0xFFF5F5F5),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: AppColors.primaryOrange),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}