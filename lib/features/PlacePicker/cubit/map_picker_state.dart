import 'package:latlong2/latlong.dart';
import 'package:practical_google_maps_example/core/utils/app_status.dart';
import 'package:practical_google_maps_example/features/PlacePicker/data/PlaceModel.dart';

class MapPickerState {
  final AppStatus status;
  final LatLng? selectedLocation;
  final String selctedLocationName;
  final String? errorMessage;
  final List<PlaceModel> searchResults;

  const MapPickerState({
    this.status = AppStatus.initial,
    this.selectedLocation,
    this.selctedLocationName = 'No location selected',
    this.errorMessage,
    this.searchResults = const [],
  });

  MapPickerState copyWith({
    AppStatus? status,
    LatLng? selectedLocation,
    String? selctedLocationName,
    String? errorMessage,
    List<PlaceModel>? searchResults,
  }) {
    return MapPickerState(
      status: status ?? this.status,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selctedLocationName: selctedLocationName ?? this.selctedLocationName,
      errorMessage: errorMessage ?? this.errorMessage,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
