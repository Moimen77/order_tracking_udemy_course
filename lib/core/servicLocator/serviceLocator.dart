import 'package:get_it/get_it.dart';
import 'package:practical_google_maps_example/features/AddOrder/cubit/add_order_cubit.dart';
import 'package:practical_google_maps_example/features/AddOrder/repo/AddOrderRepo.dart';
import 'package:practical_google_maps_example/features/PlacePicker/cubit/map_picker_cubit.dart';
import 'package:practical_google_maps_example/features/PlacePicker/repo/MapPickerRepo.dart';
import 'package:practical_google_maps_example/features/OrderScreen/cubit/order_cubit.dart';
import 'package:practical_google_maps_example/features/OrderScreen/repo/OrderRepo.dart';
import 'package:practical_google_maps_example/features/auth/cupit/authCupit.dart';
import 'package:practical_google_maps_example/features/auth/cupit/authStates.dart';
import 'package:practical_google_maps_example/features/auth/repo/AuthRepo.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(),
  );

  // Cubits
  getIt.registerFactory<Authcupit>(
    () => Authcupit(
      const LoginState(),
      repo: getIt<AuthRepo>(),
    ),
  );

  getIt.registerLazySingleton<MapPickerRepository>(
    () => MapPickerRepository(),
  );

  getIt.registerFactory<MapPickerCubit>(
    () => MapPickerCubit(
      getIt<MapPickerRepository>(),
    ),
  );

  getIt.registerLazySingleton<AddOrderRepo>(
    () => AddOrderRepo(),
  );

  getIt.registerFactory<AddOrderCubit>(
    () => AddOrderCubit(
      getIt<AddOrderRepo>(),
    ),
  );

  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepo(),
  );

  getIt.registerFactory<OrderCubit>(
    () => OrderCubit(
      getIt<OrderRepo>(),
    ),
  );
}
