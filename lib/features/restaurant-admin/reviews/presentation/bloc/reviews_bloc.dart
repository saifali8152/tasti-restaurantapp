import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/usecases/fetch_reviews.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/usecases/unverify_review.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/usecases/verify_review.dart';
import '/core/network/response.dart';
import 'reviews_event.dart';
import 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final UnVerifyReviewUsecase _unverifyUsecase;
  final VerifyReviewUsecase _verifyUsecase;
  final FetchReviewsUsecase _fetchUsecase;

  ReviewsBloc(
    this._fetchUsecase,
    this._unverifyUsecase,
    this._verifyUsecase,
  ) : super(ReviewsState(
          unverifyResponse: ApiResponse.initial(),
          verifyResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
        )) {
    on<FetchReviewsEvent>(_onFetchReviewsEvent);
    on<UnVerifyReviewEvent>(_onUnVerifyReviewEvent);
    on<VerifyReviewEvent>(_onVerifyReviewEvent);
  }

  Future<void> _onFetchReviewsEvent(
      FetchReviewsEvent event, Emitter<ReviewsState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<ReviewEntity>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onVerifyReviewEvent(
    VerifyReviewEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(state.copyWith(verifyResponse: ApiResponse.loading()));
    final result = await _verifyUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        // Move review from unverified to verified
        final currentData = state.fetchResponse.data;
        if (currentData != null) {
          final updatedUnverified =
              List<ReviewEntityData>.from(currentData.unverified);
          final updatedVerified =
              List<ReviewEntityData>.from(currentData.verified);

          final review = updatedUnverified
              .firstWhere((r) => r.reviewId == int.parse(event.parms.reviewId));
          updatedUnverified.remove(review);
          updatedVerified.add(review);

          final updatedEntity = ReviewEntity(
            verified: updatedVerified,
            unverified: updatedUnverified,
          );

          emit(state.copyWith(
            verifyResponse: ApiResponse.completed(result.data),
            fetchResponse: ApiResponse.completed(updatedEntity),
          ));
        } else {
          emit(state.copyWith(
              verifyResponse: ApiResponse.completed(result.data)));
        }
        break;

      case DataFailure():
        emit(state.copyWith(verifyResponse: ApiResponse.error(result.error)));
        break;
    }
  }

  Future<void> _onUnVerifyReviewEvent(
    UnVerifyReviewEvent event,
    Emitter<ReviewsState> emit,
  ) async {
    emit(state.copyWith(unverifyResponse: ApiResponse.loading()));
    final result = await _unverifyUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        // Move review from verified to unverified
        final currentData = state.fetchResponse.data;
        if (currentData != null) {
          final updatedVerified =
              List<ReviewEntityData>.from(currentData.verified);
          final updatedUnverified =
              List<ReviewEntityData>.from(currentData.unverified);

          final review = updatedVerified
              .firstWhere((r) => r.reviewId == int.parse(event.parms.reviewId));
          updatedVerified.remove(review);
          updatedUnverified.add(review);

          final updatedEntity = ReviewEntity(
            verified: updatedVerified,
            unverified: updatedUnverified,
          );

          emit(state.copyWith(
            unverifyResponse: ApiResponse.completed(result.data),
            fetchResponse: ApiResponse.completed(updatedEntity),
          ));
        } else {
          emit(state.copyWith(
              unverifyResponse: ApiResponse.completed(result.data)));
        }
        break;

      case DataFailure():
        emit(state.copyWith(unverifyResponse: ApiResponse.error(result.error)));
        break;
    }
  }
}
