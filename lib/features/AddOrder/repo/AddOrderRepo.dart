import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:practical_google_maps_example/core/utils/FirebaseHelper.dart';
import 'package:practical_google_maps_example/features/AddOrder/data/order_model.dart';

class AddOrderRepo {
  Future<Either<String, String>> addOrder(OrderModel order) async {
    try {
      final DocumentReference<Map<String, dynamic>> reference =
          await FirebaseService.firestore.collection('orders').add(
                order.toMap(),
              );

      return right(reference.id);
    } catch (e) {
      return left(e.toString());
    }
  }
}
