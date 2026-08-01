import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:practical_google_maps_example/core/servicLocator/serviceLocator.dart';
import 'package:practical_google_maps_example/features/PlacePicker/cubit/map_picker_cubit.dart';
import 'package:practical_google_maps_example/features/PlacePicker/repo/MapPickerRepo.dart';
import 'package:practical_google_maps_example/features/PlacePicker/view/MapPickerView.dart';

class MapPickerPage extends StatelessWidget {
  const MapPickerPage({super.key});

  static const LatLng defaultLocation = LatLng(
    30.0444,
    31.2357,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapPickerCubit(getIt<MapPickerRepository>()),
      child: const MapPickerView(),
    );
  }
}
