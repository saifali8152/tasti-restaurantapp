import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/data/models/venue.dart';
import '/core/network/response.dart';

class VenueState extends Equatable {
  final ApiResponse<VenueModel> fetchVenues;
  final ApiResponse<String> addVenues;
  final ApiResponse<String> deleteVenues;

  const VenueState({
    required this.fetchVenues,
    required this.addVenues,
    required this.deleteVenues,
  });

  VenueState copyWith({
    ApiResponse<VenueModel>? fetchVenues,
    ApiResponse<String>? addVenues,
    ApiResponse<String>? deleteVenues,
  }) {
    return VenueState(
      fetchVenues: fetchVenues ?? this.fetchVenues,
      addVenues: addVenues ?? ApiResponse.initial(),
      deleteVenues: deleteVenues ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props => [fetchVenues, addVenues, deleteVenues];
}
