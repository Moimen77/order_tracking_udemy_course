import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/PlacePicker/data/PlaceModel.dart';
import 'package:practical_google_maps_example/features/PlacePicker/repo/MapPickerRepo.dart';
import 'map_picker_state.dart';

class MapPickerCubit extends Cubit<MapPickerState> {
  final MapPickerRepository repository;

  Timer? _debounce;

  MapPickerCubit(this.repository) : super(const MapPickerState());

  Future<void> getCurrentLocation() async {
    emit(
      state.copyWith(
        status: AppStatus.loading,
      ),
    );

    final result = await repository.getCurrentLocation();

    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: AppStatus.failure,
            errorMessage: error,
          ),
        );
      },
      (position) async {
        final location = LatLng(
          position.latitude,
          position.longitude,
        );

        emit(
          state.copyWith(
            status: AppStatus.success,
            selectedLocation: location,
          ),
        );
        await getAddressFromLocation(
          location,
        );
      },
    );
  }

  Future<void> getAddressFromLocation(
    LatLng location,
  ) async {
    final result = await repository.getAddressFromLocation(
      location.latitude,
      location.longitude,
    );

    result.fold(
      (error) {
        emit(
          state.copyWith(
            errorMessage: error,
          ),
        );
      },
      (address) {
        emit(
          state.copyWith(
            selctedLocationName: address,
          ),
        );
      },
    );
  }

  void selectLocation(LatLng location) async {
    emit(
      state.copyWith(
        status: AppStatus.success,
        selectedLocation: location,
      ),
    );
    await getAddressFromLocation(
      location,
    );
  }

  void onSearchChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(
        state.copyWith(
          searchResults: [],
        ),
      );

      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        searchPlaces(query);
      },
    );
  }

  Future<void> searchPlaces(
    String query,
  ) async {
    final result = await repository.searchPlaces(query);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            searchResults: [],
            errorMessage: error,
          ),
        );
      },
      (places) {
        emit(
          state.copyWith(
            searchResults: places,
          ),
        );
      },
    );
  }

  void selectPlace(PlaceModel place) {
    final location = LatLng(
      place.latitude,
      place.longitude,
    );

    emit(
      state.copyWith(
        selectedLocation: location,
        selctedLocationName: place.displayName,
        searchResults: [],
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
