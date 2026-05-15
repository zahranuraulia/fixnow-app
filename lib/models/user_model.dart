class UserModel {
  final String id;
  final String name;
  final String email;
  final int balance; // Buat saldo dompet di dashboard

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      balance: json['balance'] ?? 0,
    );
  }
}