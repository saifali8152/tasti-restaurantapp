import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import '/features/restaurant-admin/reviews/presentation/bloc/reviews_bloc.dart';
import '/features/restaurant-admin/reviews/presentation/bloc/reviews_event.dart';
import '../widgets/review_card.dart';
import '../../../../../../../../config/constants/colors.dart';

class TabsSection extends StatelessWidget {
  final int id;
  const TabsSection({super.key, required this.id});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ReviewsBloc>().add(FetchReviewsEvent(id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = context.watch<ReviewsBloc>().state;
    final verifiedReviews = reviewsState.fetchResponse.data?.verified ?? [];
    final unverifiedReviews = reviewsState.fetchResponse.data?.unverified ?? [];

    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: AppColors.darkOrange,
            indicatorColor: Colors.deepOrange,
            splashFactory: NoSplash.splashFactory,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Verified"),
              Tab(text: "Unverified"),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                RefreshIndicator.adaptive(
                  onRefresh: () => _onRefresh(context),
                  child: _buildReviewList(verifiedReviews, true, context),
                ),
                RefreshIndicator(
                  onRefresh: () => _onRefresh(context),
                  child: _buildReviewList(unverifiedReviews, false, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(List<ReviewEntityData> reviews, bool isVerified, context) {
  if (reviews.isEmpty) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5, // Half screen height
          child: Center(
            child: Text(
              isVerified
                  ? "No verified reviews yet."
                  : "No unverified reviews yet.",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  return ListView.separated(
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: reviews.length,
    separatorBuilder: (_, __) => const SizedBox(height: 10),
    itemBuilder: (context, index) {
      return ReviewCard(
        isVerified: isVerified,
        id: id,
        review: reviews[index],
      );
    },
  );
}
}
