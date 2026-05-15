class OrderModel {
  final String id;
  final String serviceName;
  final String status;
  final String date;
  final int totalPrice;

  OrderModel({
    required this.id, 
    required this.serviceName, 
    required this.status, 
    required this.date, 
    required this.totalPrice
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      serviceName: json['service_name'],
      status: json['status'],
      date: json['date'],
      totalPrice: json['total_price'],
    );
  }
}