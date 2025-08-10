import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/presentation/widgets/unverify_review_dialog.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/presentation/widgets/verify_review_dialog.dart';
import '/config/constants/colors.dart';
import '/core/widgets/custom_button.dart';

class ReviewCard extends StatelessWidget {
  final bool isVerified;
  final int id;
  final ReviewEntityData review;
  const ReviewCard({
    super.key,
    this.isVerified = false,
    required this.id,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withSafeOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      review.reviewDate,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              /// Stars
              Row(
                children: List.generate(5, (index) {
                  if (index < review.overallRating.floor()) {
                    return Icon(Icons.star_rounded,
                        color: AppColors.pending, size: 18);
                  } else if (index < review.overallRating) {
                    return Icon(Icons.star_half_rounded,
                        color: AppColors.pending, size: 18);
                  } else {
                    return Icon(Icons.star_border_rounded,
                        color: AppColors.pending, size: 18);
                  }
                }),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Review Text
          Text(
            review.review,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          /// Button
          if (!isVerified)
            Center(
              child: CustomButton(
                onPressed: () {
                  context.showCustomDialog(
                      VerifyReviewDialog(id: id, review: review));
                },
                text: "Verify",
                isFullWidth: false,
              ),
            ),
          if (isVerified)
            Center(
              child: CustomButton(
                onPressed: () {
                  context.showCustomDialog(
                      UnverifyReviewDialog(id: id, review: review));
                },
                text: "Unverify",
                bgColor: Colors.transparent,
                borderColor: AppColors.darkOrange,
                textColor: AppColors.darkOrange,
                isFullWidth: false,
              ),
            ),
        ],
      ),
    );
  }
}
