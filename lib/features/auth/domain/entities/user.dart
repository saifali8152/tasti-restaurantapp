import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.profilePic,
    required this.phoneNumber,
    required this.token,
  });

  final String id;
  final String type;
  final String profilePic;
  final String phoneNumber;
  final String token;
  final String name;
  final String email;
  
  @override
  List < Object ? > get props => [
    id,
    type,
    phoneNumber,
    profilePic,
    token,
    name,
    email,
  ];
}