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
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.orderStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Live Tracking',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Placeholder Peta
          Container(
            color: const Color(0xFFEBEBEB),
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Text(
                '[ Area Peta / Google Maps ]',
                style: TextStyle(color: AppColors.textGrey),
              ),
            ),
          ),

          // Estimasi Waktu Atas
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      currentStatus.toLowerCase() == 'selesai'
                          ? 'Selesai dikerjakan'
                          : '5 menit lagi tiba',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Panel Detail Bawah
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Timeline Status Dinamis
                  _buildStatusStep(
                    'Pesanan Dikonfirmasi',
                    'Teknisi menerima order',
                    true,
                    true,
                  ),
                  _buildStatusStep(
                    'Teknisi Menuju Lokasi',
                    'ETA 5 menit',
                    currentStatus.toLowerCase() == 'dalam proses' ||
                        currentStatus.toLowerCase() == 'selesai',
                    false,
                    isCurrent: currentStatus.toLowerCase() == 'dalam proses',
                  ),
                  _buildStatusStep(
                    'Pekerjaan dimulai',
                    'Menunggu teknisi tiba',
                    currentStatus.toLowerCase() == 'selesai',
                    false,
                  ),
                  _buildStatusStep(
                    'Selesai',
                    '',
                    currentStatus.toLowerCase() == 'selesai',
                    false,
                    isLast: true,
                  ),

                  const SizedBox(height: 20),
                  const Divider(color: AppColors.lightGrey),
                  const SizedBox(height: 10),

                  // Profile Teknisi
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage(
                          'assets/images/ahmad_tohari.png',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.techName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const Text(
                              '4.9 • Teknisi FixNow',
                              style: TextStyle(
                                color: AppColors.textGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.phone_in_talk,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.chat_bubble,
                          color: AppColors.primaryOrange,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IsiChatView(
                                name: widget.techName,
                                role: 'Teknisi Jasa',
                                imgPath: 'assets/images/ahmad_tohari.png',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusStep(
    String title,
    String subtitle,
    bool isDone,
    bool isFirst, {
    bool isCurrent = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone
                    ? AppColors.primaryOrange
                    : (isCurrent
                          ? AppColors.primaryOrange.withOpacity(0.3)
                          : Colors.grey[300]),
                border: isCurrent
                    ? Border.all(color: AppColors.primaryOrange, width: 2)
                    : null,
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : (isCurrent
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryOrange,
                              ),
                            ),
                          )
                        : null),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 35,
                color: isDone ? AppColors.primaryOrange : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isCurrent || isDone
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: isCurrent || isDone
                      ? AppColors.textBlack
                      : AppColors.textGrey,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
