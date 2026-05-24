import 'package:flutter/material.dart';
import 'package:fixnow/constants/app_colors.dart';

class TechnicianProfilePOVView extends StatefulWidget {
  const TechnicianProfilePOVView({super.key});

  @override
  State<TechnicianProfilePOVView> createState() =>
      _TechnicianProfilePOVViewState();
}

class _TechnicianProfilePOVViewState extends State<TechnicianProfilePOVView> {
  String _namaTeknisi = 'Ahmad Thohari';
  String _deskripsiTeknisi =
      'Berpengalaman dalam memperbaiki AC rumah dan kantor, melayani sejak 2019 dengan hasil kerja bersih, rapi, cepat, dan bergaransi.';
  String _fotoProfilPath = 'assets/images/tech_profile.png';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // List simulasi gambar portofolio teknisi
  final List<String> _portfolioImages = [
    'assets/portfolio1.jpeg',
    'assets/portfolio2.jpg',
    'assets/portfolio3.jpg',
  ];

  void _openEditNameDialog() {
    _nameController.text = _namaTeknisi;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Nama'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: "Masukkan nama baru"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
            ),
            onPressed: () {
              setState(() {
                _namaTeknisi = _nameController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _openEditDescDialog() {
    _descController.text = _deskripsiTeknisi;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Tentang Saya'),
        content: TextField(
          controller: _descController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: "Tulis keahlian atau deskripsi profilmu...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
            ),
            onPressed: () {
              setState(() {
                _deskripsiTeknisi = _descController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _changeProfilePicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Simulasi: Foto profil berhasil diperbarui!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 🛠️ FIX DI SINI: Menambahkan AppBar Transparan & Tombol Back Manual/Otomatis
      extendBodyBehindAppBar:
          true, // Agar background hitam kontainer atas masuk ke bawah AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ), // Tombol panah back putih
          onPressed: () {
            Navigator.maybePop(context); // Mundur aman ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // Mengurangi padding top dari 60 ke 80 agar letak foto tidak bertabrakan dengan AppBar
              padding: const EdgeInsets.only(
                top: 80,
                left: 24,
                right: 24,
                bottom: 24,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E2A),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _changeProfilePicture,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey[700],
                          backgroundImage: AssetImage(_fotoProfilPath),
                          onBackgroundImageError: (_, __) {},
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _changeProfilePicture,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 14,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _namaTeknisi,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: _openEditNameDialog,
                        child: const Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '+62 856 0876 4779',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('24', 'order'),
                      _buildStatItem('1.3k', 'poin'),
                      _buildStatItem('4.8', 'rate kamu'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AKUN TEKNISI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    Icons.account_balance_wallet_rounded,
                    'Dompet Digital',
                    trailingText: 'Rp 250k',
                  ),
                  _buildMenuItem(Icons.stars_rounded, 'Poin & Reward'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tentang Saya',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 16,
                          color: AppColors.primaryOrange,
                        ),
                        onPressed: _openEditDescDialog,
                      ),
                    ],
                  ),
                  Text(
                    _deskripsiTeknisi,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'PORTOFOLIO SAYA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 12),

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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Hasil Kerja ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildMenuItem(
                    Icons.rate_review_rounded,
                    'Review Customer (345 Review)',
                    showArrow: true,
                  ),
                  _buildMenuItem(
                    Icons.help_center_rounded,
                    'Bantuan & Konsultasi',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String trailingText = '',
    bool showArrow = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFEFEFEF)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryOrange, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlack,
              ),
            ),
          ),
          if (trailingText.isNotEmpty)
            Text(
              trailingText,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryOrange,
              ),
            ),
          if (showArrow)
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: AppColors.textGrey,
            ),
        ],
      ),
    );
  }
}
