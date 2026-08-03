import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_google_maps_example/core/routing/app_routes.dart';
import 'package:practical_google_maps_example/core/styling/app_assets.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/utils/animated_snack_dialog.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/core/widgets/custom_text_field.dart';
import 'package:practical_google_maps_example/core/widgets/primay_button_widget.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';
import 'package:practical_google_maps_example/features/AddOrder/cubit/add_order_cubit.dart';
import 'package:practical_google_maps_example/features/AddOrder/cubit/add_order_state.dart';

class AddOrderView extends StatefulWidget {
  const AddOrderView({super.key});

  @override
  State<AddOrderView> createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController orderId;
  late final TextEditingController orderDate;
  String? locationOrder;
  double? latitudeOrder;
  double? longitudeOrder;

  @override
  void initState() {
    super.initState();
    orderId = TextEditingController();
    orderDate = TextEditingController();
  }

  @override
  void dispose() {
    orderId.dispose();
    orderDate.dispose();
    super.dispose();
  }

  Future<void> _pickLocation() async {
    final result = await GoRouter.of(context).pushNamed(AppRoutes.placePicked);

    if (result is Map) {
      setState(() {
        locationOrder = result['location']?.toString();
        latitudeOrder = (result['latitude'] as num?)?.toDouble();
        longitudeOrder = (result['longitude'] as num?)?.toDouble();
      });
      return;
    }

    if (result is String) {
      setState(() {
        locationOrder = result;
      });
    }
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (value != null) {
      setState(() {
        orderDate.text = "${value.day}/${value.month}/${value.year}";
      });
    }
  }

  void _resetForm() {
    orderId.clear();
    orderDate.clear();
    setState(() {
      locationOrder = null;
      latitudeOrder = null;
      longitudeOrder = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state.status == AppStatus.success) {
          showAnimatedSnackDialog(
            context,
            message: "Order created successfully",
            type: AnimatedSnackBarType.success,
          );
          _resetForm();
          context.read<AddOrderCubit>().resetStatus();
        }

        if (state.status == AppStatus.failure) {
          showAnimatedSnackDialog(
            context,
            message: state.errorMessage ?? "Something went wrong",
            type: AnimatedSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final addOrderCubit = context.read<AddOrderCubit>();
        final isLoading = state.status == AppStatus.loading;

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightSpace(28),
                      SizedBox(
                        width: 335.w,
                        child: Text(
                          "Add Order Details",
                          style: AppStyles.primaryHeadLinesStyle,
                        ),
                      ),
                      const HeightSpace(8),
                      SizedBox(
                        width: 335.w,
                        child: Text(
                          "Add your order information to track your order location",
                          style: AppStyles.grey12MediumStyle,
                        ),
                      ),
                      const HeightSpace(20),
                      Center(
                        child: Image.asset(
                          AppAssets.logo,
                          width: 190.w,
                          height: 190.w,
                        ),
                      ),
                      const HeightSpace(32),
                      Text(
                        "Order ID",
                        style: AppStyles.black16w500Style,
                      ),
                      const HeightSpace(16),
                      CustomTextField(
                        controller: orderId,
                        hintText: "Enter Order ID",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Order ID";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text(
                        "Order Date",
                        style: AppStyles.black16w500Style,
                      ),
                      const HeightSpace(16),
                      CustomTextField(
                        controller: orderDate,
                        hintText: "Select Order Date",
                        onTap: _pickDate,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Order Date";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      PrimayButtonWidget(
                        buttonText: "Add Order Location",
                        isLoading: false,
                        onPress: isLoading ? null : _pickLocation,
                      ),
                      const HeightSpace(15),
                      Text(
                        locationOrder ?? "No location selected",
                        style: AppStyles.black16w500Style,
                      ),
                      if (latitudeOrder != null && longitudeOrder != null) ...[
                        const HeightSpace(8),
                        Text(
                          "Lat: ${latitudeOrder!.toStringAsFixed(6)}, Lng: ${longitudeOrder!.toStringAsFixed(6)}",
                          style: AppStyles.grey12MediumStyle,
                        ),
                      ],
                      const HeightSpace(20),
                      PrimayButtonWidget(
                        buttonText: "Create the Order",
                        isLoading: isLoading,
                        onPress: isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  addOrderCubit.addOrder(
                                    orderId: orderId.text.trim(),
                                    orderDate: orderDate.text.trim(),
                                    location: locationOrder!,
                                    latitude: latitudeOrder!,
                                    longitude: longitudeOrder!,
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
