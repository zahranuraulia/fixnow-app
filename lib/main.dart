import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

// IMPORT HALAMAN VIEWS
import 'package:fixnow/views/splash_view.dart';
import 'package:fixnow/views/register_view.dart';
import 'package:fixnow/views/total_ulasan_view.dart';
import 'package:fixnow/views/dashboard/home_view.dart';
import 'package:fixnow/views/dashboard/category_detail_view.dart';
import 'package:fixnow/views/booking/detail_layanan_view.dart';
import 'package:fixnow/views/booking/order_summary_view.dart';
import 'package:fixnow/views/booking/payment_method_view.dart';
import 'package:fixnow/views/booking/select_schedule_view.dart';
import 'package:fixnow/views/booking/success_booking_view.dart';
import 'package:fixnow/views/chat/isi_chat_view.dart';
import 'package:fixnow/views/chat/message_list_view.dart';
import 'package:fixnow/views/activity/tracking_service_view.dart';
import 'package:fixnow/views/chat/bot_chat_view.dart';
import 'package:fixnow/views/main_navigation_view.dart'; // File navbar utama kamu

// Import file technician_view.dart
import 'package:fixnow/views/profile/technician_view.dart';
import 'package:fixnow/views/technician/all_reviews_view.dart';

// Placeholder untuk view yang belum dibuat atau tidak wajib
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class CallingView extends StatelessWidget {
  const CallingView({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryOrange,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryOrange,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(
              bodyColor: AppColors.textBlack,
              displayColor: AppColors.textBlack,
            ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.textBlack,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashView());
          case '/login':
            return MaterialPageRoute(builder: (_) => const OnboardingView());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterView());

          // 🛠️ PERBAIKAN UTAMA: Rute ini sekarang memanggil MainNavigationView, bukan HomeView polosan!
          case '/main_nav':
            return MaterialPageRoute(
              builder: (context) {
                // Menangkap argumen index tab jika dikirim (misal: dilempar ke tab riwayat)
                final args = settings.arguments as Map<String, dynamic>?;
                final index =
                    args?['initialIndex'] ?? 0; // Default ke Home jika kosong
                return MainNavigationView(initialIndex: index);
              },
            );

          // Dashboard
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomeView());
          case '/category_detail':
            return MaterialPageRoute(
              builder: (_) => const CategoryDetailView(),
            );
          case '/bot_chat':
            return MaterialPageRoute(builder: (_) => const BotChatView());

          // Alur Booking
          // Alur Booking
          case '/detail_layanan':
            return MaterialPageRoute(
              builder: (context) {
                // Mengambil argumen yang dikirim saat melakukan Navigator.pushNamed
                final args =
                    ModalRoute.of(context)?.settings.arguments
                        as Map<String, dynamic>?;
                return DetailLayananView(
                  serviceName: args?['serviceName'] ?? 'Jasa Perbaikan',
                  // Jika dari API tidak ada gambarnya, kita lempar langsung ke network fallback Unsplash online
                  serviceImage:
                      args?['serviceImage'] ??
                      'https://images.unsplash.com/photo-1581092921461-eab62e97a780?w=500',
                );
              },
            );
          case '/order_summary':
            return MaterialPageRoute(
              builder: (_) {
                final args = settings.arguments as Map<String, dynamic>?;
                return OrderSummaryView(
                  technicianData:
                      args?['technicianData'] ??
                      {'name': 'Ahmad Thohari', 'role': 'Handyman'},
                  selectedDate: args?['selectedDay'] ?? 23,
                  selectedTime: args?['selectedTime'] ?? '09.00',
                );
              },
            );

          case '/payment_method':
            return MaterialPageRoute(
              builder: (_) {
                final args = settings.arguments as Map<String, dynamic>?;
                return PaymentMethodView(
                  technicianData:
                      args?['technicianData'] ??
                      {'name': 'Ahmad Thohari', 'role': 'Handyman'},
                  selectedDate: args?['selectedDay'] ?? 23,
                  selectedTime: args?['selectedTime'] ?? '09.00',
                );
              },
            );
          case '/select_schedule':
            return MaterialPageRoute(
              builder: (_) => const SelectScheduleView(
                technicianData: {'name': 'Ahmad Thohari', 'role': 'Handyman'},
              ),
            );
          case '/success_booking':
            return MaterialPageRoute(
              builder: (_) => const SuccessBookingView(
                technicianData: {'name': 'Ahmad Thohari', 'role': 'Handyman'},
                selectedDay: 23,
                selectedTime: '09.00',
              ),
            );

          // Fitur Chat
          case '/calling':
            return MaterialPageRoute(builder: (_) => const CallingView());
          case '/chat_room':
            return MaterialPageRoute(builder: (_) => const ChatRoomView());
          case '/isi_chat':
            return MaterialPageRoute(
              builder: (_) => const IsiChatView(
                name: 'Teknisi',
                role: 'FixNow Team',
                imgPath: '',
              ),
            );
          case '/message_list':
            return MaterialPageRoute(builder: (_) => const MessageListView());

          // Aktivitas / Riwayat
          case '/history_order':
          case '/history_pemesanan':
          case '/tracking_service':
            return MaterialPageRoute(
              builder: (_) => const LiveTrackingView(
                serviceName: 'Service AC Split',
                techName: 'Ahmad Thohari',
                orderStatus: 'Teknisi Menuju Lokasi',
              ),
            );

          // Profil & Teknisi
          case '/user_profile':
            return MaterialPageRoute(
              builder: (_) => const TechnicianProfilePOVView(),
            );
          case '/technician_detail':
            return MaterialPageRoute(
              builder: (_) => const TechnicianProfilePOVView(),
            );
          case '/all_reviews':
            return MaterialPageRoute(builder: (_) => const AllReviewsView());
          case '/total_ulasan':
            return MaterialPageRoute(
              builder: (_) {
                final args = settings.arguments as Map<String, dynamic>?;
                return TotalUlasanView(
                  technicianId: args?['technicianId'] ?? '',
                  technicianName: args?['technicianName'] ?? 'Teknisi',
                );
              },
            );

          default:
            return MaterialPageRoute(builder: (_) => const SplashView());
        }
      },
    );
  }
}
