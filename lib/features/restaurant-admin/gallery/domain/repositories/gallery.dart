import '/features/restaurant-admin/gallery/domain/entities/gallery.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IGalleryRepo {
  Future<DataState<String>> deleteGallery(String id);
  Future<DataState<String>> addGallery(AddGalleryParms parms);
  Future<DataState<List<GalleryEntity>>> fetchGallery(String id);
}
