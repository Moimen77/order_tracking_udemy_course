import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/servicLocator/serviceLocator.dart';
import 'package:practical_google_maps_example/features/OrderScreen/cubit/order_cubit.dart';
import 'package:practical_google_maps_example/features/OrderScreen/view/OrderView.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderCubit>(
      create: (_) => getIt<OrderCubit>(),
      child: const OrderView(),
    );
  }
}
