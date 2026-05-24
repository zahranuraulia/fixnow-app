import 'package:fixnow/views/membership_view.dart';
import 'package:fixnow/views/total_ulasan_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnow/constants/app_colors.dart';
import 'package:fixnow/views/login_view.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  String _userRole = 'user'; 
  bool _isLoading = true;

  final List<String> _portfolioImages = [
    'assets/images/portfolio1.png',
    'assets/images/portfolio2.png',
    'assets/images/portfolio3.png',
    'assets/images/portfolio4.png',
  ];

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString('role') ?? 'user'; 
      _isLoading = false;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Konfirmasi Keluar', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Apakah Anda yakin ingin keluar dari akun ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                if (!mounted) return;

                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (route) => false,
                );
              },
              child: const Text('Keluar', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primaryOrange)),
      );
    }

    if (_userRole == 'technician') {
      return _buildTechnicianProfileUI(); 
    } else {
      return _buildCustomerProfileUI(); 
    }
  }

  Widget _buildCustomerProfileUI() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderProfile(name: "Zahra Aulia", roleTag: "user", status: "Gold Member"),
            const SizedBox(height: 20),
            _buildMenuSection("AKUN", [
              _buildMenuItem(Icons.account_balance_wallet_outlined, "Dompet Digital", trailingText: "Rp 250k"),
              _buildMenuItem(Icons.stars_rounded, "Poin & Reward"),
              _buildMenuItem(
                Icons.card_membership, 
                "Membership", 
                hasBadge: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipView()));
                },
              ),
              _buildMenuItem(Icons.g_translate, "Bahasa"),
              _buildMenuItem(Icons.location_on_outlined, "Alamat Tersimpan"),
            ]),
            _buildMenuSection("LAINNYA", [
              _buildMenuItem(Icons.headset_mic_outlined, "Bantuan & Konsultasi"),
              _buildMenuItem(Icons.logout_rounded, "Keluar Akun", isDestructive: true, onTap: _showLogoutDialog),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicianProfileUI() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderProfile(name: "Ahmad Thohari", roleTag: "handyman", status: "Verified"),
            const SizedBox(height: 20),
            _buildMenuSection("AKUN", [
              _buildMenuItem(Icons.account_balance_wallet_outlined, "Dompet Digital", trailingText: "Rp 250k"),
              _buildMenuItem(Icons.stars_rounded, "Poin & Reward"),
              _buildMenuItem(
                Icons.card_membership, 
                "Membership", 
                hasBadge: true,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MembershipView()));
                },
              ),
              _buildMenuItem(Icons.g_translate, "Bahasa"),
              _buildMenuItem(Icons.location_on_outlined, "Alamat Tersimpan"),
              _buildMenuItem(Icons.rate_review_outlined, "Review Customer", onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TotalUlasanView(
                      technicianId: 'ID_AHMAD_THOHARI', 
                      technicianName: 'Ahmad Thohari',
                    ),
                  ),
                );
              }),
            ]),
            
            // SECTION TENTANG SAYA & PORTOFOLIO DI AKUN TEKNISI (USER_VIEW)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tentang Saya', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textBlack)),
                  const SizedBox(height: 6),
                  const Text(
                    'Berpengalaman dalam memperbaiki AC rumah dan kantor, melayani sejak 2019 dengan hasil kerja bersih, rapi, cepat, dan bergaransi.',
                    style: TextStyle(fontSize: 13, color: AppColors.textGrey, height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  const Text('PORTOFOLIO SAYA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textGrey)),
                  const SizedBox(height: 12),
                  
                  // 🛠️ FIX: Penempatan List Portofolio Gambar di halaman UserProfileView versi Teknisi
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _portfolioImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(_portfolioImages[index]),
                              fit: BoxFit.cover,
                              onError: (_, __) {},
                            ),
                          ),
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(4)),
                            child: Text('Hasil Kerja ${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 9)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            _buildMenuSection("LAINNYA", [
              _buildMenuItem(Icons.headset_mic_outlined, "Bantuan & Konsultasi"),
              _buildMenuItem(Icons.logout_rounded, "Keluar Akun", isDestructive: true, onTap: _showLogoutDialog),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderProfile({required String name, required String roleTag, required String status}) {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 20, left: 24, right: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E24),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 35, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 40, color: Colors.white)),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.primaryOrange, borderRadius: BorderRadius.circular(10)),
                          child: Text(roleTag, style: const TextStyle(color: Colors.white, fontSize: 10)),
                        )
                      ],
                    ),
                    const Text("+62 856 0876 4779", style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Colors.yellow[700], borderRadius: BorderRadius.circular(12)),
                      child: Text(status, style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white), onPressed: () {})
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("24", "order"),
              _buildStatItem("1.3k", "poin"),
              _buildStatItem("4.8", "rate kamu"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const SizedBox(height: 10),
          Card(
            elevation: 2,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(children: items),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailingText, bool hasBadge = false, bool isDestructive = false, VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap ?? () {},
      leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.textBlack),
      title: Text(title, style: TextStyle(fontSize: 14, color: isDestructive ? Colors.red : AppColors.textBlack, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null) Text(trailingText, style: const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold, fontSize: 13)),
          if (hasBadge) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(8)), child: const Text("member", style: TextStyle(color: AppColors.primaryOrange, fontSize: 10))),
          const SizedBox(width: 5),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}