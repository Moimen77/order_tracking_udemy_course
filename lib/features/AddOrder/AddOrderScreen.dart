import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practical_google_maps_example/core/routing/app_routes.dart';
import 'package:practical_google_maps_example/core/styling/app_assets.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/widgets/custom_text_field.dart';
import 'package:practical_google_maps_example/core/widgets/primay_button_widget.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController orderId;
  late TextEditingController orderDate;
  String? locationOrder;

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

  @override
  Widget build(BuildContext context) {
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

                  // ================= Username =================

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
                    hintText: "Enter Order Date",
                    onTap: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 1))
                          .then((value) {
                        if (value != null) {
                          setState(() {
                            orderDate.text =
                                "${value.day}/${value.month}/${value.year}";
                          });
                        }
                      });
                    },
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
                      onPress: () {
                        locationOrder =
                            Navigator.pushNamed(context, AppRoutes.placePicked)
                                as String?;
                        setState(() {});
                      }),

                  const HeightSpace(15),

                  Text(
                    locationOrder ?? "No location selected",
                    style: AppStyles.black16w500Style,
                  ),

                  const HeightSpace(20),

                  PrimayButtonWidget(
                      buttonText: "Create the Order",
                      isLoading: false,
                      onPress: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
