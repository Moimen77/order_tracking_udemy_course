import 'package:latlong2/latlong.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';

class MapPickerState {
  final AppStatus status;
  final LatLng? selectedLocation;
  final String? errorMessage;

  const MapPickerState({
    this.status = AppStatus.initial,
    this.selectedLocation,
    this.errorMessage,
  });

  MapPickerState copyWith({
    AppStatus? status,
    LatLng? selectedLocation,
    String? errorMessage,
  }) {
    return MapPickerState(
      status: status ?? this.status,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
