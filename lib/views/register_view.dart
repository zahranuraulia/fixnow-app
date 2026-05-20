import 'package:flutter/material.dart';
// TODO: Sesuaikan import di bawah ini dengan path project FixNow kamu
import 'package:fixnow/views/dashboard/home_view.dart'; 
import 'package:fixnow/services/api_service.dart';
import 'package:fixnow/models/category_model.dart';
import 'package:fixnow/views/detail_layanan_view.dart';
import 'package:fixnow/models/technician_model.dart';
import 'package:fixnow/models/user_model.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Controller untuk mengambil data dari inputan (opsional/bisa disesuaikan)
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo FixNow
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      TextSpan(text: 'Fix', style: TextStyle(color: Colors.black)),
                      TextSpan(text: 'Now', style: TextStyle(color: Color(0xFFFF7A45))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Judul Halaman
              const Text(
                "Buat akun mu!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Kami siap membantu permasalahan mu",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),

              // Input Nama Lengkap
              const Text(
                "Masukkan nama lengkap",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFFFF2EC),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFD0BC)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFF7A45), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input E-mail / No HP
              const Text(
                "Masukkan e-mail / No hp",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailPhoneController,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFFFF2EC),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFD0BC)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFF7A45), width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input Password
              const Text(
                "Password",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _isPasswordObscured,
                decoration: InputDecoration(
                  fillColor: const Color(0xFFF1F1F1),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFF7A45), width: 1.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // TOMBOL DAFTAR (FIXED)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Berpindah ke HomeView dan menghapus tumpukan halaman sebelumnya
                    // Catatan: Pastikan class HomeView() sudah kamu import di bagian atas file ini
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()), 
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7A45), // Warna Oranye FixNow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // TEKS LOGIN SEKARANG (FIXED)
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sudah punya akun? ",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Menutup halaman register untuk kembali ke halaman Login awal
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login Sekarang",
                        style: TextStyle(
                          color: Color(0xFFFF7A45),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

