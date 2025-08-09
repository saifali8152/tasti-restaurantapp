import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/domain/repositories/menu_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class AddMenuUsecase extends UseCase<DataState<String>, UploadMenuParms>{
  final IMenuRepo repo;
  
  AddMenuUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.uploadMenu(parm);
  }
}