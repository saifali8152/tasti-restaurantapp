import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/data/models/menu.dart';
import '/core/network/response.dart';

class MenuState extends Equatable {
  final ApiResponse<MenuModel> fetchResponse;
  final ApiResponse<String> addResponse;

  const MenuState({
    required this.fetchResponse,
    required this.addResponse,
  });

  MenuState copyWith({
    ApiResponse<MenuModel>? fetchResponse,
    ApiResponse<String>? addResponse,
  }) {
    return MenuState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      addResponse: addResponse ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props => [fetchResponse, addResponse];
}
