class OrderModel {
  final String orderId;
  final String orderDate;
  final String userId;
  final String location;
  final double latitude;
  final double longitude;

  const OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.userId,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'orderDate': orderDate,
      'userId': userId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
}
