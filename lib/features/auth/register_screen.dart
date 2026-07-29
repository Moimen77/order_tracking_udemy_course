import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_google_maps_example/core/servicLocator/serviceLocator.dart';
import 'package:practical_google_maps_example/core/styling/app_assets.dart';
import 'package:practical_google_maps_example/core/styling/app_colors.dart';
import 'package:practical_google_maps_example/core/styling/app_styles.dart';
import 'package:practical_google_maps_example/core/utils/animated_snack_dialog.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/core/widgets/custom_text_field.dart';
import 'package:practical_google_maps_example/core/widgets/primay_button_widget.dart';
import 'package:practical_google_maps_example/core/widgets/spacing_widgets.dart';
import 'package:practical_google_maps_example/features/auth/cupit/authCupit.dart';
import 'package:practical_google_maps_example/features/auth/cupit/authStates.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  bool isPasswordVisible = true;
  bool isPasswordVisible2 = true;

  @override
  void initState() {
    super.initState();

    username = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    email.dispose();
    confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<Authcupit>(),
      child: BlocConsumer<Authcupit, LoginState>(
        listener: (context, state) {
          if (state.status == AppStatus.success) {
            showAnimatedSnackDialog(
              context,
              message: "Account created successfully",
              type: AnimatedSnackBarType.success,
            );

            // بعد إنشاء الحساب نرجع للـ Login
            context.pop();
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
          final cubit = context.read<Authcupit>();

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
                            "Create an account",
                            style: AppStyles.primaryHeadLinesStyle,
                          ),
                        ),

                        const HeightSpace(8),

                        SizedBox(
                          width: 335.w,
                          child: Text(
                            "Let’s create your account.",
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
                          "User Name",
                          style: AppStyles.black16w500Style,
                        ),

                        const HeightSpace(8),

                        CustomTextField(
                          controller: username,
                          hintText: "Enter Your User Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your User Name";
                            }

                            return null;
                          },
                        ),

                        const HeightSpace(16),

                        // ================= Email =================

                        Text(
                          "Email",
                          style: AppStyles.black16w500Style,
                        ),

                        const HeightSpace(8),

                        CustomTextField(
                          controller: email,
                          hintText: "Enter Your Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Email";
                            }

                            return null;
                          },
                        ),

                        const HeightSpace(16),

                        // ================= Password =================

                        Text(
                          "Password",
                          style: AppStyles.black16w500Style,
                        ),

                        const HeightSpace(8),

                        CustomTextField(
                          hintText: "Enter Your Password",
                          controller: password,
                          suffixIcon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.greyColor,
                            size: 20.sp,
                          ),
                          isPassword: isPasswordVisible,
                          onIconTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Your Password";
                            }

                            if (value.length < 8) {
                              return "Password must be at least 8 characters";
                            }

                            return null;
                          },
                        ),

                        const HeightSpace(16),

                        // ================= Confirm Password =================

                        Text(
                          "Confirm Password",
                          style: AppStyles.black16w500Style,
                        ),

                        const HeightSpace(8),

                        CustomTextField(
                          hintText: "Confirm Your Password",
                          controller: confirmPassword,
                          isPassword: isPasswordVisible2,
                          onIconTap: () {
                            setState(() {
                              isPasswordVisible2 = !isPasswordVisible2;
                            });
                          },
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: AppColors.greyColor,
                            size: 20.sp,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Confirm Your Password";
                            }

                            if (value.length < 8) {
                              return "Password must be at least 8 characters";
                            }

                            if (value != password.text) {
                              return "Password does not match";
                            }

                            return null;
                          },
                        ),

                        const HeightSpace(55),

                        // ================= Register Button =================

                        PrimayButtonWidget(
                          buttonText: "Create Account",
                          isLoading: state.status == AppStatus.loading,
                          onPress: state.status == AppStatus.loading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.signUp(
                                      email.text.trim(),
                                      password.text.trim(),
                                    );
                                  }
                                },
                        ),

                        const HeightSpace(8),

                        Center(
                          child: InkWell(
                            onTap: () {
                              context.pop();
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Do you have account? ",
                                style: AppStyles.black16w500Style.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: AppStyles.black15BoldStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const HeightSpace(16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
