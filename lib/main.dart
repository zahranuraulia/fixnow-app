import 'package:flutter/material.dart';

// Import halaman utama (Relative Path)
import 'views/splash_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart' hide HomeView;
import 'views/dashboard/home_view.dart';
import 'views/dashboard/category_detail_view.dart';

// Import sub-fitur tambahan
import 'views/live_tracking_view.dart';
import 'views/total_ulasan_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixNow App',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        // Menggunakan font bawaan tanpa memanggil library internet agar anti-error
        fontFamily: 'Poppins',
      ),
      
      initialRoute: '/splash',
      
      routes: {
        '/splash': (context) => const SplashView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(),
        '/category_detail': (context) => const CategoryDetailView(),
        '/live_tracking': (context) => const LiveTrackingView(),
        '/total_ulasan': (context) => const TotalUlasanView(),
      },
    );
  }
}