import '/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({super.name});

  factory UserModel.fromJson(Map<String, dynamic> json ){
    return UserModel(
      name: json['name']
    );
  }
}