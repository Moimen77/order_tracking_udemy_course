class OrderModel {
  final String orderId;
  final String orderDate;
  final String userId;
  final String location;
  final double latitude;
  final double longitude;
  final String? createdAt;

  const OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.userId,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.createdAt,
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

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId']?.toString() ?? '',
      orderDate: map['orderDate']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      createdAt: map['createdAt']?.toString(),
    );
  }
}
