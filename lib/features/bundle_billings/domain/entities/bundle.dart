import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class BundleEntity extends Equatable {
  final List<BundleItem> data;
  final PaginationModel pagination;

  const BundleEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class BundleItem extends Equatable {
  final int eventId;
  final String eventTitle;
  final String eventImage;
  final String eventLink;

  const BundleItem({
    required this.eventId,
    required this.eventTitle,
    required this.eventImage,
    required this.eventLink,
  });

  @override
  List<Object?> get props => [
        eventId,
        eventTitle,
        eventImage,
        eventLink,
      ];
}

