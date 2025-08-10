import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import '/core/network/response.dart';

class ReviewsState extends Equatable {
  final ApiResponse<String> unverifyResponse;
  final ApiResponse<String> verifyResponse;
  final ApiResponse<ReviewEntity> fetchResponse;

  const ReviewsState({
    required this.unverifyResponse,
    required this.verifyResponse,
    required this.fetchResponse,
  });

  ReviewsState copyWith({
    ApiResponse<String>? unverifyResponse,
    ApiResponse<String>? verifyResponse,
    ApiResponse<ReviewEntity>? fetchResponse,
  }) {
    return ReviewsState(
      unverifyResponse: unverifyResponse ?? ApiResponse.initial(),
      verifyResponse: verifyResponse ?? this.verifyResponse,
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse, verifyResponse, unverifyResponse];
}
