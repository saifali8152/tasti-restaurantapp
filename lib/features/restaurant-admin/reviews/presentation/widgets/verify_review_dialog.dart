import '/core/parms/parms.dart';
import '/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import '/features/restaurant-admin/reviews/presentation/bloc/reviews_bloc.dart';
import '/features/restaurant-admin/reviews/presentation/bloc/reviews_event.dart';
import '/features/restaurant-admin/reviews/presentation/bloc/reviews_state.dart';
import '/core/network/response.dart';
import '/core/utils/flushbar_extention.dart';
import '/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class VerifyReviewDialog extends StatelessWidget {
  final int id;
  final ReviewEntityData review;
  const VerifyReviewDialog({super.key, required this.id, required this.review});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Colors.black),
              ),
            ),
            const Icon(Icons.logout, size: 48),
            const SizedBox(height: 16),
            const Text(
              'Alert',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Are you sure you want to proceed? This action cannot be undone.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            BlocConsumer<ReviewsBloc, ReviewsState>(
              bloc: context.read<ReviewsBloc>(),
              listener: (context, state) {
                if (state.verifyResponse.status == Status.error) {
                  context.flushBarErrorMessage(
                      message: state.verifyResponse.message.toString());
                }
                if (state.verifyResponse.status == Status.completed) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Navigator.pop(context),
                        text: "Cancel",
                        bgColor: Colors.white,
                        textColor: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          context.read<ReviewsBloc>().add(
                                VerifyReviewEvent(
                                  VerifyUnverifyReviewParms(
                                    id: id,
                                    reviewId: review.reviewId.toString(),
                                  ),
                                ),
                              );
                        },
                        text: "Confirm",
                        isLoading:
                            state.verifyResponse.status == Status.loading,
                        bgColor: Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
