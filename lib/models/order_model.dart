class OrderModel {
  final String id;
  final String serviceName;
  final String status;
  final String date;
  final int totalPrice;
  final String? technicianId; // 🛠️ TAMBAHKAN INI (Gunakan tanda ? agar aman jika null)

  OrderModel({
    required this.id, 
    required this.serviceName, 
    required this.status, 
    required this.date, 
    required this.totalPrice,
    this.technicianId, // 🛠️ TAMBAHKAN INI
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      serviceName: json['service_name'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
      totalPrice: json['total_price'] ?? 0,
      technicianId: json['tech_id'] ?? json['technician_id'], // 🛠️ MENYESUAIKAN DARI BACKEND
    );
  }
}