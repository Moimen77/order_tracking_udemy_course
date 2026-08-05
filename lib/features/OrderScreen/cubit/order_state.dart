import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/AddOrder/data/order_model.dart';

class OrderState {
  final AppStatus status;
  final String? errorMessage;
  final List<OrderModel> orders;

  const OrderState({
    this.status = AppStatus.initial,
    this.errorMessage,
    this.orders = const [],
  });

  static const Object _unset = Object();

  OrderState copyWith({
    AppStatus? status,
    Object? errorMessage = _unset,
    List<OrderModel>? orders,
  }) {
    return OrderState(
      status: status ?? this.status,
      errorMessage:
          identical(errorMessage, _unset) ? this.errorMessage : errorMessage as String?,
      orders: orders ?? this.orders,
    );
  }
}
