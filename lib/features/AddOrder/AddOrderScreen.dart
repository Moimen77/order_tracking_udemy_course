import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_google_maps_example/core/servicLocator/serviceLocator.dart';
import 'package:practical_google_maps_example/features/AddOrder/cubit/add_order_cubit.dart';
import 'package:practical_google_maps_example/features/AddOrder/view/AddOrderView.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddOrderCubit>(
      create: (_) => getIt<AddOrderCubit>(),
      child: const AddOrderView(),
    );
  }
}
