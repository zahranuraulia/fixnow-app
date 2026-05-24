import 'package:flutter/material.dart';
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/models/technician_model.dart';

class BookingController extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State Data Transaksi Booking
  TechnicianModel? selectedTechnician;
  int selectedDay = 9; 
  String selectedTime = '10:00';
  String serviceName = 'Service AC Split'; // Default service sesuai UI

  // Biaya Tetap (Bisa diubah dinamis nanti jika ada data dari API)
  final int biayaPerjalanan = 10000;
  final int diskonPromo = 36000;
  bool isLoading = false;

  // Menginisialisasi data awal saat masuk alur booking
  void initBookingData(Map<String, dynamic> techData, int day, String time) {
    selectedTechnician = TechnicianModel.fromJson(techData);
    selectedDay = day;
    selectedTime = time;
    notifyListeners();
  }

  // Update Tanggal
  void updateSelectedDay(int day) {
    selectedDay = day;
    notifyListeners();
  }

  // Update Jam
  void updateSelectedTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  // Getter menghitung harga layanan (diambil dari harga asli teknisi)
  int get hargaLayanan => selectedTechnician?.price ?? 120000;

  // Getter menghitung total akhir pembayaran secara dinamis
  int get totalPembayaran {
    int total = hargaLayanan + biayaPerjalanan - diskonPromo;
    return total < 0 ? 0 : total; // Mencegah total minus jika promo terlalu besar
  }

  // Format String Tanggal untuk dikirim ke Backend (Contoh: "2026-03-09")
  String get formattedDateBackend {
    final dayStr = selectedDay < 10 ? '0$selectedDay' : '$selectedDay';
    return '2026-03-$dayStr';
  }

  // Fungsi Kirim Order ke API Backend
  Future<bool> submitOrder() async {
    if (selectedTechnician == null) return false;

    isLoading = true;
    notifyListeners();

    bool success = await _apiService.createOrder(
      serviceName: serviceName,
      date: '$formattedDateBackend | $selectedTime',
      totalPrice: totalPembayaran,
      technicianId: selectedTechnician!.id,
    );

    isLoading = false;
    notifyListeners();
    return success;
  }
}