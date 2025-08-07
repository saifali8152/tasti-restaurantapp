import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/entities/gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/repositories/gallery.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchGalleryUsecase extends UseCase<DataState<List<GalleryEntity>>, String>{
  final IGalleryRepo repo;
  
  FetchGalleryUsecase(this.repo);

  @override
  Future<DataState<List<GalleryEntity>>> call(parm) {
    return repo.fetchGallery(parm);
  }
}