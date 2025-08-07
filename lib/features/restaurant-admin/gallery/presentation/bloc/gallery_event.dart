import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}
class FetchGalleryEvent extends GalleryEvent {
  final String id;

  const FetchGalleryEvent(this.id);
}

class DeleteGalleryEvent extends GalleryEvent {
  final String id;

  const DeleteGalleryEvent(this.id);
}

class AddGalleryEvent extends GalleryEvent {
  final AddGalleryParms parms;

  const AddGalleryEvent(this.parms);
}
