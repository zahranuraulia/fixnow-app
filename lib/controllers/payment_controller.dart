import 'package:flutter/material.dart';

class PaymentController extends ChangeNotifier {
  // Nilai default sesuai mockup Figma
  int _hargaLayanan = 120000;
  int _biayaPerjalanan = 10000;
  int _diskonPromo = 0;
  
  String _selectedMethod = 'E-wallet'; // Default metode pembayaran
  String _appliedPromoCode = '';
  bool _isProcessing = false;

  // Getters
  int get hargaLayanan => _hargaLayanan;
  int get biayaPerjalanan => _biayaPerjalanan;
  int get diskonPromo => _diskonPromo;
  int get totalPembayaran => (_hargaLayanan + _biayaPerjalanan) - _diskonPromo;
  String get selectedMethod => _selectedMethod;
  String get appliedPromoCode => _appliedPromoCode;
  bool get isProcessing => _isProcessing;

  // Set nilai awal berdasarkan data dinamis jika diperlukan
  void initPaymentData({required int basePrice}) {
    _hargaLayanan = basePrice;
    _diskonPromo = 0;
    _appliedPromoCode = '';
    notifyListeners();
  }

  // Mengubah metode pembayaran (E-wallet, Transfer Bank, COD)
  void setPaymentMethod(String method) {
    _selectedMethod = method;
    notifyListeners();
  }

  // Fungsi klaim/pakai kode promo (Simulasi FIXNOW350 mendapat diskon Rp 36.000)
  bool applyPromo(String code) {
    if (code.trim().toUpperCase() == 'FIXNOW350') {
      _diskonPromo = 36000; // Sesuai dengan mockup Ringkasan Pesanan kamu
      _appliedPromoCode = 'FIXNOW350';
      notifyListeners();
      return true;
    }
    return false;
  }

  // Menghapus promo yang terpasang
  void removePromo() {
    _diskonPromo = 0;
    _appliedPromoCode = '';
    notifyListeners();
  }

  // Simulasi proses checkout pembayaran
  Future<bool> processPayment() async {
    _isProcessing = true;
    notifyListeners();

    try {
      // Simulasi delay hit API payment gateway (Midtrans/Xendit dsb)
      await Future.delayed(const Duration(seconds: 15));
      _isProcessing = false;
      notifyListeners();
      return true; // Pembayaran sukses
    } catch (e) {
      _isProcessing = false;
      notifyListeners();
      return false;
    }
  }
}