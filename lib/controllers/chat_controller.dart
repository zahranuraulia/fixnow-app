import 'package:flutter/material.dart';

class ChatMessage {
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

class ChatController extends ChangeNotifier {
  // Menyimpan daftar chat berdasarkan ID Teknisi / ID Room Chat
  final Map<String, List<ChatMessage>> _chatHistory = {};
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // Mengambil pesan berdasarkan ID Teknisi
  List<ChatMessage> getMessages(String technicianId) {
    return _chatHistory[technicianId] ?? [];
  }

  // Fungsi untuk memuat chat awal (Simulasi API)
  Future<void> fetchChatHistory(String technicianId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulasi delay manggil API backend
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (!_chatHistory.containsKey(technicianId)) {
        _chatHistory[technicianId] = [
          ChatMessage(
            senderId: technicianId,
            text: "Halo! Saya teknisi yang akan menangani AC Anda. Saya sedang menuju ke lokasi.",
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
            isMe: false,
          ),
        ];
      }
    } catch (e) {
      debugPrint("Error fetch chat: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk mengirim pesan baru
  void sendMessage(String technicianId, String messageText) {
    if (messageText.trim().isEmpty) return;

    final newMessage = ChatMessage(
      senderId: 'user_current',
      text: messageText,
      timestamp: DateTime.now(),
      isMe: true,
    );

    if (_chatHistory.containsKey(technicianId)) {
      _chatHistory[technicianId]!.add(newMessage);
    } else {
      _chatHistory[technicianId] = [newMessage];
    }
    
    notifyListeners();
  }
}