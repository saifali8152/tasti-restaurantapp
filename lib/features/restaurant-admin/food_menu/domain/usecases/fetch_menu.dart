import '/features/restaurant-admin/food_menu/domain/entities/menu.dart';
import '/features/restaurant-admin/food_menu/domain/repositories/menu_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchMenuUsecase extends UseCase<DataState<MenuEntity>, String>{
  final IMenuRepo repo;
  
  FetchMenuUsecase(this.repo);

  @override
  Future<DataState<MenuEntity>> call(parm) {
    return repo.fetchMenu(parm);
  }
}