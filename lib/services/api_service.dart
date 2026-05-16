import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fixnow/models/technician_model.dart';
import 'package:fixnow/models/user_model.dart';
import 'package:fixnow/models/category_model.dart';
import 'package:fixnow/models/order_model.dart';
import 'package:fixnow/models/review_model.dart';

class ApiService {
  // GANTI link ini dengan URL Railway kamu yang ada di browser kemarin!
  static const String baseUrl =
      'https://fixnow-backend-production-5584.up.railway.app';

  Future<List<TechnicianModel>> getTechnicians() async {
    final response = await http.get(Uri.parse('$baseUrl/technicians'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => TechnicianModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data teknisi');
    }
  }

  // Tambahkan ini di dalam class ApiService kamu yang kemarin
  Future<UserModel?> login(String email, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users?email=$email&password=$password'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      if (data.isNotEmpty) {
        return UserModel.fromJson(data[0]);
      }
    }
    return null; // Balikin null kalau login gagal
  }

  // Tambahkan di bawah fungsi login
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => CategoryModel.fromJson(item)).toList();
    }
    return [];
  }

  Future<List<OrderModel>> getOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => OrderModel.fromJson(item)).toList();
    }
    return [];
  }

  // Jangan lupa import review_model.dart di atas!

  Future<List<ReviewModel>> getReviewsByTech(String techId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reviews?tech_id=$techId'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => ReviewModel.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  Future<bool> addReview(ReviewModel review) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reviews'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'tech_id': review.techId,
        'user_name': review.userName,
        'rating': review.rating,
        'comment': review.comment,
        'date': DateTime.now().toString().split(
          ' ',
        )[0], // Ambil tanggal hari ini
      }),
    );

    return response.statusCode ==
        201; // 201 artinya data berhasil dibuat di server
  }
}
