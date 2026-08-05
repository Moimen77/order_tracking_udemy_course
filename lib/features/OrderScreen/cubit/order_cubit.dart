import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/utils/FirebaseHelper.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/OrderScreen/cubit/order_state.dart';
import 'package:practical_google_maps_example/features/OrderScreen/repo/OrderRepo.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(this.repository) : super(const OrderState());

  final OrderRepo repository;

  Future<void> fetchOrders() async {
    final userId = FirebaseService.currentUser?.uid;

    if (userId == null) {
      emit(
        state.copyWith(
          status: AppStatus.failure,
          errorMessage: 'You must be logged in to view orders',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AppStatus.loading,
        errorMessage: null,
      ),
    );

    final result = await repository.getUserOrders(userId);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: AppStatus.failure,
            errorMessage: error,
          ),
        );
      },
      (orders) {
        emit(
          state.copyWith(
            status: AppStatus.success,
            orders: orders,
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
      ),
    );
  }
}
