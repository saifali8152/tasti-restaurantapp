part of 'skaleton_cubit.dart';

class UserCubitState {
  final UserEntity? user;

  UserCubitState({this.user});

  UserCubitState copyWith({UserEntity? user}) {
    return UserCubitState(
      user: user ?? this.user,
    );
  }
}
