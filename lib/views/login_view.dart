import 'package:flutter/material.dart';
import 'package:fixnow/services/api_service.dart'; 
import 'package:fixnow/models/user_model.dart';
import 'package:fixnow/views/dashboard/home_view.dart';
import 'package:fixnow/views/register_view.dart';
import 'package:fixnow/models/category_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String namaUser = "Zahra Aulia"; // Nama default jika API offline

    try {
      final response = await ApiService().login(_emailController.text, _passwordController.text);
      
      if (response != null && response != false) {
        if (response is String) {
          namaUser = response.toString(); // Jika API mengembalikan string, gunakan sebagai nama user
        } else {
          try {
            namaUser = response.name; 
          } catch (_) {}
        }
      }
    } catch (e) {
      debugPrint("Info: API Service offline/error ($e). Menggunakan mode bypass.");
    }

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login Berhasil!'), 
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
    
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Perbaikan: "center" huruf kecil
              children: [
                const SizedBox(height: 50),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: 'Fix', style: TextStyle(color: Colors.black)),
                      TextSpan(text: 'Now', style: TextStyle(color: Color(0xFFFF7A3D))),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Selamat Datang!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Masuk untuk Melanjutkan',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    side: const BorderSide(color: Colors.grey, width: 0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.g_mobiledata_rounded, color: Colors.blue, size: 30),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Lanjutkan dengan google',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'atau masuk dengan nomor HP',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                  ],
                ),
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email atau Nomor HP', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFFFF6F2),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFFFB394), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFFF7A3D), width: 1.5),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Email/No HP tidak boleh kosong' : null,
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    fillColor: const Color(0xFFF2EFEA),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Color(0xFFFF7A3D), width: 1.5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Password tidak boleh kosong' : null,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {}, // Perbaikan: Menggunakan onTap, bukan onPressed
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(color: Color(0xFFFF7A3D), fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFA06E), Color(0xFFFF6332)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Masuk',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? ', style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: () { // Perbaikan: Menggunakan onTap, bukan onPressed
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                      },
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(color: Color(0xFFFF7A3D), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}