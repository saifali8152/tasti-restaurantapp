import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/data/models/venue.dart';
import '/core/network/response.dart';

class VenueState extends Equatable {
  final ApiResponse<VenueModel> fetchVenues;
  final ApiResponse<String> addVenues;
  final ApiResponse<String> deleteVenues;
  final String selectedCategories;

  const VenueState({
    required this.fetchVenues,
    required this.addVenues,
    required this.deleteVenues,
    required this.selectedCategories,
  });

  VenueState copyWith({
    ApiResponse<VenueModel>? fetchVenues,
    ApiResponse<String>? addVenues,
    ApiResponse<String>? deleteVenues,
    String? selectedCategories,
  }) {
    return VenueState(
      fetchVenues: fetchVenues ?? this.fetchVenues,
      addVenues: addVenues ?? ApiResponse.initial(),
      deleteVenues: deleteVenues ?? ApiResponse.initial(),
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [fetchVenues, addVenues, deleteVenues, selectedCategories];
}
