import 'package:flutter/material.dart';
// 1. IMPORT semua halaman yang ada di struktur folder Anda
import 'views/splash_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'views/dashboard/home_view.dart';
import 'views/dashboard/category_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixNow App',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug di kanan atas
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      
      // 2. ATUR halaman pertama yang dibuka adalah SplashView
      initialRoute: '/splash', 
      
      // 3. DAFTARKAN rute navigasi untuk semua halaman
      routes: {
        '/splash': (context) => const SplashView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(),
        '/category_detail': (context) => const CategoryDetailView(),
      },
    );
  }
}