import '/features/restaurant-admin/gallery/domain/repositories/gallery.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class DeleteGalleryUsecase extends UseCase<DataState<String>, String>{
  final IGalleryRepo repo;
  
  DeleteGalleryUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.deleteGallery(parm);
  }
}