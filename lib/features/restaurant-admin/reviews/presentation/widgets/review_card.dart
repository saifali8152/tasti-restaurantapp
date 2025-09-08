import 'package:flutter/material.dart';
import '/core/utils/general_extentions.dart';
import '/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import '/features/restaurant-admin/reviews/presentation/widgets/unverify_review_dialog.dart';
import '/features/restaurant-admin/reviews/presentation/widgets/verify_review_dialog.dart';
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

  void _openImageGallery(BuildContext context, int initialIndex) {
  final PageController pageController = PageController(initialPage: initialIndex);
  final ValueNotifier<int> currentPage = ValueNotifier<int>(initialIndex);

  showDialog(
    context: context,
    barrierColor: Colors.black87,
    builder: (_) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: review.images.length,
                  onPageChanged: (index) => currentPage.value = index,
                  itemBuilder: (context, index) {
                    final imageUrl = review.images[index];
                    return Center(
                      child: InteractiveViewer(
                        clipBehavior: Clip.none,
                        panEnabled: true,
                        minScale: 0.8,
                        maxScale: 4.0,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                /// Page Indicator
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ValueListenableBuilder<int>(
                      valueListenable: currentPage,
                      builder: (context, value, _) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${value + 1} / ${review.images.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


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
                      style: const TextStyle(
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
                    return const Icon(Icons.star_rounded,
                        color: AppColors.pending, size: 18);
                  } else if (index < review.overallRating) {
                    return const Icon(Icons.star_half_rounded,
                        color: AppColors.pending, size: 18);
                  } else {
                    return const Icon(Icons.star_border_rounded,
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
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.4,
            ),
          ),

          /// Review Images
          if (review.images.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: review.images.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final imageUrl = review.images[index];
                  return Container(
                    color: Colors.grey.shade100,
                    child: GestureDetector(
                      onTap: () => _openImageGallery(context, index),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 16),

          /// Button
          if (!isVerified)
            Center(
              child: CustomButton(
                onPressed: () {
                  context.showCustomDialog(
                    VerifyReviewDialog(id: id, review: review),
                  );
                },
                text: "Verify",
                isFullWidth: false,
              ),
            ),
          if (isVerified && review.images.isEmpty)
            Center(
              child: CustomButton(
                onPressed: () {
                  context.showCustomDialog(
                    UnverifyReviewDialog(id: id, review: review),
                  );
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
