import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/PlacePicker/repo/MapPickerRepo.dart';
import 'map_picker_state.dart';

class MapPickerCubit extends Cubit<MapPickerState> {
  final MapPickerRepository repository;

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
      (position) {
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
      },
    );
  }

  void selectLocation(LatLng location) {
    emit(
      state.copyWith(
        status: AppStatus.success,
        selectedLocation: location,
      ),
    );
  }
}
