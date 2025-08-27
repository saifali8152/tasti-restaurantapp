class ReviewEntity {
  final List<ReviewEntityData> verified;
  final List<ReviewEntityData> unverified;

  const ReviewEntity({
    required this.verified,
    required this.unverified,
  });
}

class ReviewEntityData {
  final int reviewId;
  final String review;
  final double foodRating;
  final double serviceRating;
  final double ambienceRating;
  final double overallRating;
  final String userName;
  final String reviewDate;
  final List<String> images;

  const ReviewEntityData({
    required this.reviewId,
    required this.review,
    required this.foodRating,
    required this.serviceRating,
    required this.ambienceRating,
    required this.overallRating,
    required this.userName,
    required this.reviewDate,
    required this.images,
  });
}
