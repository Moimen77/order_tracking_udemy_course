import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:practical_google_maps_example/core/utils/animated_snack_dialog.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/PlacePicker/view/MapPickerPage.dart';

import '../cubit/map_picker_cubit.dart';
import '../cubit/map_picker_state.dart';

class MapPickerView extends StatefulWidget {
  const MapPickerView({super.key});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Location',
        ),
      ),
      body: BlocConsumer<MapPickerCubit, MapPickerState>(
        listener: (context, state) {
          if (state.status == AppStatus.failure && state.errorMessage != null) {
            showAnimatedSnackDialog(context, message: state.errorMessage);
          }

          if (state.selectedLocation != null) {
            mapController.move(
              state.selectedLocation!,
              15,
            );
          }
        },
        builder: (context, state) {
          final location =
              state.selectedLocation ?? MapPickerPage.defaultLocation;

          return Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: location,
                  initialZoom: 13,
                  onTap: (tapPosition, point) {
                    context.read<MapPickerCubit>().selectLocation(point);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                    subdomains: const ['a', 'b', 'c', 'd'],
                    userAgentPackageName: 'com.abdallah.example_google_map',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: location,
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.location_pin,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (state.status == AppStatus.loading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    final location = state.selectedLocation;

                    if (location == null) {
                      return;
                    }

                    debugPrint(
                      'Latitude: ${location.latitude}',
                    );

                    debugPrint(
                      'Longitude: ${location.longitude}',
                    );
                  },
                  child: const Text(
                    'Confirm Location',
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 100,
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<MapPickerCubit>().getCurrentLocation();
                  },
                  child: const Icon(
                    Icons.my_location,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
