import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practical_google_maps_example/core/styling/app_colors.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/utils/animated_snack_dialog.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/core/widgets/loading_widget.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';
import 'package:practical_google_maps_example/features/AddOrder/data/order_model.dart';
import 'package:practical_google_maps_example/features/OrderScreen/cubit/order_cubit.dart';
import 'package:practical_google_maps_example/features/OrderScreen/cubit/order_state.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().fetchOrders();
  }

  Widget _buildOrderCard(OrderModel order) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.orderId}',
              style: AppStyles.black16w500Style,
            ),
            const HeightSpace(8),
            Text(
              'Order Date: ${order.orderDate}',
              style: AppStyles.grey12MediumStyle,
            ),
            const HeightSpace(8),
            Text(
              'Location: ${order.location}',
              style: AppStyles.grey12MediumStyle,
            ),
            const HeightSpace(8),
            Text(
              'Coordinates: ${order.latitude}, ${order.longitude}',
              style: AppStyles.grey12MediumStyle,
            ),
            const HeightSpace(16),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {},
                child: Text('Track Order', style: AppStyles.black16w500Style),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state.status == AppStatus.failure && state.errorMessage != null) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage!,
            type: AnimatedSnackBarType.error,
          );
          context.read<OrderCubit>().resetStatus();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Orders',
              style: AppStyles.primaryHeadLinesStyle
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state.status == AppStatus.loading) {
                return const LoadingWidget();
              }

              if (state.orders.isEmpty) {
                return Center(
                  child: Text(
                    'No orders found for this user',
                    style:
                        AppStyles.grey12MediumStyle.copyWith(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<OrderCubit>().fetchOrders(),
                child: ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(state.orders[index]);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
