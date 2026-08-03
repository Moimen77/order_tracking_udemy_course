import 'package:practical_google_maps_example/core/utils/app_status.dart';

class AddOrderState {
  final AppStatus status;
  final String? errorMessage;
  final String? successMessage;
  final String? orderId;
  final String? orderDate;
  final String? userId;
  final String? location;
  final double? latitude;
  final double? longitude;

  const AddOrderState({
    this.status = AppStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.orderId,
    this.orderDate,
    this.userId,
    this.location,
    this.latitude,
    this.longitude,
  });

  static const Object _unset = Object();

  AddOrderState copyWith({
    AppStatus? status,
    Object? errorMessage = _unset,
    Object? successMessage = _unset,
    Object? orderId = _unset,
    Object? orderDate = _unset,
    Object? userId = _unset,
    Object? location = _unset,
    Object? latitude = _unset,
    Object? longitude = _unset,
  }) {
    return AddOrderState(
      status: status ?? this.status,
      errorMessage:
          identical(errorMessage, _unset) ? this.errorMessage : errorMessage as String?,
      successMessage: identical(successMessage, _unset)
          ? this.successMessage
          : successMessage as String?,
      orderId: identical(orderId, _unset) ? this.orderId : orderId as String?,
      orderDate:
          identical(orderDate, _unset) ? this.orderDate : orderDate as String?,
      userId: identical(userId, _unset) ? this.userId : userId as String?,
      location: identical(location, _unset) ? this.location : location as String?,
      latitude:
          identical(latitude, _unset) ? this.latitude : latitude as double?,
      longitude:
          identical(longitude, _unset) ? this.longitude : longitude as double?,
    );
  }
}
