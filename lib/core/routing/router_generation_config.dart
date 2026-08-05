import 'package:go_router/go_router.dart';

import 'package:practical_google_maps_example/core/routing/app_routes.dart';
import 'package:practical_google_maps_example/core/utils/FirebaseHelper.dart';
import 'package:practical_google_maps_example/features/AddOrder/AddOrderScreen.dart';
import 'package:practical_google_maps_example/features/PlacePicker/view/MapPickerPage.dart';
import 'package:practical_google_maps_example/features/OrderScreen/OrderScreen.dart';
import 'package:practical_google_maps_example/features/auth/login_screen.dart';
import 'package:practical_google_maps_example/features/auth/register_screen.dart';
import 'package:practical_google_maps_example/features/homeScreen/HomeScreen.dart';
import 'package:practical_google_maps_example/features/splash_screen/splash_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
      redirect: (context, state) async {
        final isLoggedIn = FirebaseService.currentUser != null;

        final isGoingToHome = state.matchedLocation == AppRoutes.mainScreen;
        final isGoingToLogin = state.matchedLocation == AppRoutes.loginScreen;

        if (isLoggedIn && !isGoingToHome && isGoingToLogin) {
          return AppRoutes.mainScreen;
        }

        return null;
      },
      initialLocation: AppRoutes.splashScreen,
      routes: [
        GoRoute(
          name: AppRoutes.splashScreen,
          path: AppRoutes.splashScreen,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: AppRoutes.loginScreen,
          path: AppRoutes.loginScreen,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: AppRoutes.registerScreen,
          path: AppRoutes.registerScreen,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          name: AppRoutes.mainScreen,
          path: AppRoutes.mainScreen,
          builder: (context, state) => const homeScreen(),
        ),
        GoRoute(
          name: AppRoutes.addOrder,
          path: AppRoutes.addOrder,
          builder: (context, state) => const AddOrderScreen(),
        ),
        GoRoute(
          name: AppRoutes.orderScreen,
          path: AppRoutes.orderScreen,
          builder: (context, state) => const OrderScreen(),
        ),
        GoRoute(
          name: AppRoutes.placePicked,
          path: AppRoutes.placePicked,
          builder: (context, state) => const MapPickerPage(),
        )
      ]);
}
