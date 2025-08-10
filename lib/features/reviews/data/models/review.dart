import 'package:tasti_restaurant_app/features/reviews/domain/entities/reviews.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.verified,
    required super.unverified,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
  return ReviewModel(
    verified: (json['verified'] as List<dynamic>? ?? [])
        .map((e) => ReviewDataModel.fromJson(e))
        .toList(),
    unverified: (json['unverified'] as List<dynamic>? ?? [])
        .map((e) => ReviewDataModel.fromJson(e))
        .toList(),
  );
}


  Map<String, dynamic> toJson() {
    return {
      'data': {
        'verified': verified
            .map((e) => (e as ReviewDataModel).toJson())
            .toList(),
        'unverified': unverified
            .map((e) => (e as ReviewDataModel).toJson())
            .toList(),
      },
    };
  }
}

class ReviewDataModel extends ReviewEntityData {
  const ReviewDataModel({
    required super.reviewId,
    required super.review,
    required super.foodRating,
    required super.serviceRating,
    required super.ambienceRating,
    required super.overallRating,
    required super.userName,
    required super.reviewDate,
  });

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewDataModel(
      reviewId: json['review_id'] ?? 0,
      review: json['review'] ?? '',
      foodRating: (json['food_rating'] as num?)?.toDouble() ?? 0.0,
      serviceRating: (json['service_rating'] as num?)?.toDouble() ?? 0.0,
      ambienceRating: (json['ambience_rating'] as num?)?.toDouble() ?? 0.0,
      overallRating: (json['overall_rating'] as num?)?.toDouble() ?? 0.0,
      userName: json['user_name'] ?? '',
      reviewDate: json['review_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review_id': reviewId,
      'review': review,
      'food_rating': foodRating,
      'service_rating': serviceRating,
      'ambience_rating': ambienceRating,
      'overall_rating': overallRating,
      'user_name': userName,
      'review_date': reviewDate,
    };
  }
}
