class TechnicianModel {
  final String id;
  final String name;
  final String specialization;
  final double rating;
  final String experience;
  final String description;
  final String imageUrl;
  final int price;
  final String? skill;
  final String? exp;
  final String? vendor;

  TechnicianModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.skill,
    this.exp,
    this.vendor,
  });

  // Fungsi untuk konversi dari JSON ke Objek Dart
  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Tanpa Nama',
      specialization: json['specialization'] ?? json['skill'] ?? 'Teknisi Umum',
      rating: (json['rating'] ?? 5.0).toDouble(),
      experience: json['experience'] ?? json['exp'] ?? '1 Tahun',
      description: json['description'] ?? '-',
      imageUrl: json['image_url'] ?? '',
      price: json['price'] ?? 0,
      skill: json['skill'] ?? json['specialization'],
      exp: json['exp'] ?? json['experience'],
      vendor: json['vendor'] ?? 'FixNow Partner',
    );
  }
}