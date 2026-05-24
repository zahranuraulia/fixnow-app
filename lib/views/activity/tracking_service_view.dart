import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/views/chat/isi_chat_view.dart';

class LiveTrackingView extends StatefulWidget {
  final String serviceName;
  final String techName;
  final String orderStatus;

  const LiveTrackingView({
    super.key,
    required this.serviceName,
    required this.techName,
    required this.orderStatus,
  });

  @override
  State<LiveTrackingView> createState() => _LiveTrackingViewState();
}

class _LiveTrackingViewState extends State<LiveTrackingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pelacakan Pesanan',
          style: TextStyle(
            color: AppColors.textBlack,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // 1. AREA PETA SIMULASI
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFE8F4FD),
              child: Stack(
                children: [
                  Positioned(
                    top: 100, left: -20,
                    child: Container(width: 400, height: 15, color: Colors.white),
                  ),
                  Positioned(
                    top: 0, left: 150,
                    child: Container(width: 15, height: 400, color: Colors.white),
                  ),
                  const Positioned(
                    top: 100,
                    left: 142,
                    child: Icon(
                      Icons.person_pin_circle_rounded,
                      color: Colors.blue,
                      size: 32,
                    ),
                  ),
                  const Positioned(
                    top: 220,
                    left: 142,
                    child: Icon(
                      Icons.moped_rounded,
                      color: AppColors.primaryOrange,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. CARD LIVE STATUS STEPPER & AKSI CHAT
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.techName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.serviceName,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                        // 🛠️ FIX ELEMEN CHAT: Mengirim parameter yang diminta IsiChatView
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IsiChatView(
                                  name: widget.techName,
                                  role: 'Teknisi FixNow',
                                  imgPath: 'assets/images/delivery.png', // Sesuaikan jika ada path gambar asli
                                ), 
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEFEA),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFFFDCD0)),
                            ),
                            child: const Icon(
                              Icons.chat_bubble_rounded,
                              color: AppColors.primaryOrange,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Divider(color: Color(0xFFEFEFEF)),
                    ),

                    _buildStepStatus(
                      icon: Icons.check_circle_rounded,
                      title: 'Pesanan Dikonfirmasi',
                      time: '20:51',
                      isCompleted: true,
                    ),
                    _buildStepLine(isCompleted: true),
                    _buildStepStatus(
                      icon: Icons.moped_rounded,
                      title: 'Teknisi Menuju Lokasi',
                      time: 'Sedang Berjalan',
                      isCompleted: true,
                      isActiveNow: true,
                    ),
                    _buildStepLine(isCompleted: false),
                    _buildStepStatus(
                      icon: Icons.build_circle_rounded,
                      title: 'Pengerjaan Service',
                      time: '--:--',
                      isCompleted: false,
                    ),
                    _buildStepLine(isCompleted: false),
                    _buildStepStatus(
                      icon: Icons.stars_rounded,
                      title: 'Selesai',
                      time: '--:--',
                      isCompleted: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepStatus({
    required IconData icon,
    required String title,
    required String time,
    required bool isCompleted,
    bool isActiveNow = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: isActiveNow 
              ? AppColors.primaryOrange 
              : (isCompleted ? const Color(0xFF27AE60) : const Color(0xFFD0D0D0)),
          size: 24,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActiveNow || isCompleted ? FontWeight.bold : FontWeight.normal,
                  color: isActiveNow 
                      ? AppColors.primaryOrange 
                      : (isCompleted ? AppColors.textBlack : AppColors.textGrey),
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: isActiveNow ? AppColors.primaryOrange : AppColors.textGrey,
            fontWeight: isActiveNow ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine({required bool isCompleted}) {
    return Container(
      margin: const EdgeInsets.only(left: 11),
      height: 24,
      width: 2,
      color: isCompleted ? const Color(0xFF27AE60) : const Color(0xFFEFEFEF),
    );
  }
}