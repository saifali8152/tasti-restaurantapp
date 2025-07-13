import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.type,
    required super.profilePic,
    required super.phoneNumber,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'].toString(),
        token: json['token'].toString(),
        type: json['type'].toString(),
        profilePic: json['profile_pic'].toString(),
        phoneNumber: json['phone_number'].toString(),
        name: json['name'].toString(),
        email: json['email'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'name': name,
        'email': email,
        'type': type,
        'phone_number': phoneNumber,
        'profile_pic': profilePic,
      };

  UserEntity toEntity() => UserEntity(
        id: id,
        token: token,
        name: name,
        email: email,
        type: type,
        profilePic: profilePic,
        phoneNumber: phoneNumber,
      );

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      token: entity.token,
      name: entity.name,
      email: entity.email,
      type: entity.type,
      phoneNumber: entity.phoneNumber,
      profilePic: entity.profilePic,
    );
  }

  UserModel copyWith({
    String? id,
    String? token,
    String? name,
    String? email,
    String? type,
    String? profilePic,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      type: type ?? this.type,
      profilePic: profilePic ?? this.profilePic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
