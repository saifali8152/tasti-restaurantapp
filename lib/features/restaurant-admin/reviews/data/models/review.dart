import '/features/restaurant-admin/reviews/domain/entities/reviews.dart';

double _parseJsonDouble(dynamic value, [double fallback = 0.0]) {
  if (value == null || value.toString().isEmpty) return fallback;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? fallback;
}

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
    required super.images,
  });

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewDataModel(
      reviewId: json['review_id'] ?? 0,
      review: json['review'] ?? '',
      foodRating: _parseJsonDouble(json['food_rating']),
      serviceRating: _parseJsonDouble(json['service_rating']),
      ambienceRating: _parseJsonDouble(json['ambience_rating']),
      overallRating: _parseJsonDouble(json['overall_rating']),
      userName: json['user_name'] ?? '',
      reviewDate: json['review_date'] ?? '',
      images: (json['images'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ?? [],

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
      'images':images
    };
  }
}
