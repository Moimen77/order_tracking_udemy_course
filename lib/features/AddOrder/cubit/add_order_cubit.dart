import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/utils/FirebaseHelper.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/AddOrder/cubit/add_order_state.dart';
import 'package:practical_google_maps_example/features/AddOrder/data/order_model.dart';
import 'package:practical_google_maps_example/features/AddOrder/repo/AddOrderRepo.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.repository) : super(const AddOrderState());

  final AddOrderRepo repository;

  Future<void> addOrder({
    required String orderId,
    required String orderDate,
    required String? location,
    required double? latitude,
    required double? longitude,
  }) async {
    final userId = FirebaseService.currentUser?.uid;

    if (userId == null) {
      emit(
        state.copyWith(
          status: AppStatus.failure,
          errorMessage: "You must be logged in to add an order",
        ),
      );
      return;
    }

    if (location == null || latitude == null || longitude == null) {
      emit(
        state.copyWith(
          status: AppStatus.failure,
          errorMessage: "Please select an order location",
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AppStatus.loading,
        errorMessage: null,
        successMessage: null,
      ),
    );

    final result = await repository.addOrder(
      OrderModel(
        orderId: orderId,
        orderDate: orderDate,
        userId: userId,
        location: location,
        latitude: latitude,
        longitude: longitude,
      ),
    );

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: AppStatus.failure,
            errorMessage: error,
          ),
        );
      },
      (documentId) {
        emit(
          state.copyWith(
            status: AppStatus.success,
            successMessage: documentId,
          ),
        );
      },
    );
  }

  void resetStatus() {
    emit(
      state.copyWith(
        status: AppStatus.initial,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }
}
