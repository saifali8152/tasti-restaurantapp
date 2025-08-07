import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/entities/gallery.dart';
import '/core/network/response.dart';

class GalleryState extends Equatable {
  final ApiResponse<String> deleteResponse;
  final ApiResponse<String> addResponse;
  final ApiResponse<List<GalleryEntity>> fetchResponse;

  const GalleryState({
    required this.deleteResponse,
    required this.addResponse,
    required this.fetchResponse,
  });

  GalleryState copyWith({
    ApiResponse<String>? deleteResponse,
    ApiResponse<String>? addResponse,
    ApiResponse<List<GalleryEntity>>? fetchResponse,
  }) {
    return GalleryState(
      deleteResponse: deleteResponse ?? ApiResponse.initial(),
      addResponse: addResponse ?? ApiResponse.initial(),
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse, addResponse, deleteResponse];
}
