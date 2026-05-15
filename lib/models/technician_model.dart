class TechnicianModel {
  final String id;
  final String name;
  final String specialization;
  final double rating;
  final String experience;
  final String imageUrl;
  final int price;

  TechnicianModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.experience,
    required this.imageUrl,
    required this.price,
  });

  // Fungsi untuk konversi dari JSON ke Objek Dart
  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    return TechnicianModel(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      rating: json['rating'].toDouble(),
      experience: json['experience'],
      imageUrl: json['image_url'],
      price: json['price'],
    );
  }
}