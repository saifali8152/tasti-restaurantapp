import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/domain/entities/menu.dart';

class MenuModel extends MenuEntity {
  MenuModel({
    required super.menu,
    required super.exampleMenu,
    required super.isUploaded,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menu: json['qr_code_url'].toString(),
      exampleMenu: json['menu'].toString(),
      isUploaded: json['isUploaded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qr_code_url': menu,
      'menu': exampleMenu,
      'isUploaded': isUploaded,
    };
  }

  MenuModel copyWith({
    String? menu,
    String? exampleMenu,
    int? isUploaded,
  }) {
    return MenuModel(
      menu: menu ?? this.menu,
      exampleMenu: exampleMenu ?? this.exampleMenu,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }
}
