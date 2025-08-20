import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object?> get props => [];
}
class FetchReviewsEvent extends ReviewsEvent {
  final String id;

  const FetchReviewsEvent(this.id);
}

class VerifyReviewEvent extends ReviewsEvent {
  final VerifyUnverifyReviewParms parms;

  const VerifyReviewEvent(this.parms);
}

class UnVerifyReviewEvent extends ReviewsEvent {
  final VerifyUnverifyReviewParms parms;

  const UnVerifyReviewEvent(this.parms);
}
