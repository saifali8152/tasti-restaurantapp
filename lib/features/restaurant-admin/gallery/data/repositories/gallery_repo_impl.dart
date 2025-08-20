import '/features/restaurant-admin/gallery/data/models/gallery.dart';
import '/core/parms/parms.dart';
import '../data_sources/gallery_repo.dart';
import '../../domain/repositories/gallery.dart';
import '/core/network/response.dart';

class GalleryRepoImpl extends IGalleryRepo {
  final IGalleryRemoteApi remote;
  GalleryRepoImpl(this.remote);

  @override
  Future<DataState<String>> addGallery(AddGalleryParms parms) async {
    try {
      final result = await remote.addGallery(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deleteGallery(String id) async {
    try {
      final result = await remote.deleteGallery(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<GalleryModel>>> fetchGallery(String id) async {
    try {
      final result = await remote.fetchGallery(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
