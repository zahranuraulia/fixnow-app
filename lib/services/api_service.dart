import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnow/models/technician_model.dart';
import 'package:fixnow/models/user_model.dart';
import 'package:fixnow/models/category_model.dart';
import 'package:fixnow/models/order_model.dart';
import 'package:fixnow/models/review_model.dart';

class ApiService {
  // URL Backend Railway Aktif
  static const String baseUrl = 'https://fixnow-backend-production-5584.up.railway.app';

  // ===========================================================================
  // 1. FITUR UTAMA: AUTHENTICATION (LOGIN & SESSION SAVE)
  // ===========================================================================
  
  /// Fungsi Login yang otomatis mendeteksi & menyimpan ID serta ROLE ke internal HP
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        
        Map<String, dynamic>? userMap;
        if (decodedData is List && decodedData.isNotEmpty) {
          userMap = decodedData[0];
        } else if (decodedData is Map<String, dynamic>) {
          userMap = decodedData;
        }

        if (userMap != null) {
          UserModel user = UserModel.fromJson(userMap);

          // Simpan data penting ke SharedPreferences agar halaman Profile tahu rolenya!
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', user.id ?? '');
          await prefs.setString('name', user.name ?? '');
          await prefs.setString('email', user.email ?? '');
          await prefs.setString('role', userMap['role'] ?? 'user'); 

          return user;
        }
      }
      return null;
    } catch (e) {
      print('Error Login API: $e');
      return null;
    }
  }

  /// Fungsi untuk Logout (Menghapus sesi login di HP)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus seluruh data login
  }

  // ===========================================================================
  // 2. FITUR TEKNISI & KATEGORI
  // ===========================================================================

  /// Mengambil semua data teknisi aktif
  Future<List<TechnicianModel>> getTechnicians() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/technicians'));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((item) => TechnicianModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat data teknisi');
      }
    } catch (e) {
      print('Error getTechnicians: $e');
      return [];
    }
  }

  /// Mengambil kategori layanan (AC, Cleaning, Listrik, dll)
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories'));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((item) => CategoryModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error getCategories: $e');
      return [];
    }
  }

  // ===========================================================================
  // 3. FITUR ORDERS (PESANAN)
  // ===========================================================================

  /// Mengambil list orderan keseluruhan
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/orders'));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((item) => OrderModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error getOrders: $e');
      return [];
    }
  }

  /// Menambahkan pesanan baru ke server Railway setelah checkout
  Future<bool> createOrder({
    required String serviceName,
    required String date,
    required int totalPrice,
    required String technicianId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_name': serviceName,
          'status': 'Pending', // Status awal pesanan baru
          'date': date,
          'total_price': totalPrice,
          'technician_id': technicianId,
        }),
      );
      
      // Biasanya backend merespon 201 Created untuk penambahan data berhasil
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Error createOrder API: $e');
      return false;
    }
  }

  // ===========================================================================
  // 4. FITUR REVIEWS & ULASAN CUSTOMER
  // ===========================================================================

  /// Mengambil ulasan spesifik milik salah satu teknisi berdasarkan ID (Kembalian Typed Model)
  Future<List<ReviewModel>> getReviewsByTech(String techId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews?tech_id=$techId'),
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((item) => ReviewModel.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error getReviewsByTech: $e');
      return [];
    }
  }

  /// Mengambil ulasan spesifik untuk halaman dinamis TotalUlasanView (Kembalian List Dinamis)
  Future<List<dynamic>> getReviewsByTechnician(String? techId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/reviews?tech_id=${techId ?? ""}'),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Gagal memuat ulasan backend');
      }
    } catch (e) {
      print('Error getReviewsByTechnician: $e');
      return [];
    }
  }

  /// Menambahkan ulasan baru ke server Railway setelah pengerjaan selesai
  Future<bool> addReview(ReviewModel review) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reviews'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'tech_id': review.techId,
          'user_name': review.userName,
          'rating': review.rating,
          'comment': review.comment,
          'date': DateTime.now().toString().split(' ')[0], // Format tanggal YYYY-MM-DD
        }),
      );
      return response.statusCode == 201; 
    } catch (e) {
      print('Error addReview: $e');
      return false;
    }
  }

  // ===========================================================================
  // 5. ADD-ON: FITUR PORTOFOLIO TEKNISI (Sesuai Kebutuhan Desain Figma Kamu)
  // ===========================================================================

  /// Fungsi mengambil galeri portofolio dari teknisi berdasarkan ID pendaftaran pengerjaan
  Future<List<String>> getPortfolioByTech(String techId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/portfolios?tech_id=$techId'));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        if (data.isNotEmpty && data[0]['images'] != null) {
          return List<String>.from(data[0]['images']);
        }
      }
      return [];
    } catch (e) {
      print('Error getPortfolioByTech: $e');
      return [];
    }
  }
}