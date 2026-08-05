import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:practical_google_maps_example/core/utils/FirebaseHelper.dart';
import 'package:practical_google_maps_example/features/AddOrder/data/order_model.dart';

class OrderRepo {
  Future<Either<String, List<OrderModel>>> getUserOrders(String userId) async {
    try {
      final querySnapshot = await FirebaseService.firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      final orders = querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList()
        ..sort(
          (first, second) {
            final firstCreatedAt = first.createdAt ?? '';
            final secondCreatedAt = second.createdAt ?? '';
            return secondCreatedAt.compareTo(firstCreatedAt);
          },
        );

      return right(orders);
    } catch (e) {
      return left(e.toString());
    }
  }
}
