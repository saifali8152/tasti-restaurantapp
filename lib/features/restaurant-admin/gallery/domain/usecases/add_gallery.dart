import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/repositories/gallery.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddGalleryUsecase extends UseCase<DataState<String>, AddGalleryParms>{
  final IGalleryRepo repo;
  
  AddGalleryUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.addGallery(parm);
  }
}