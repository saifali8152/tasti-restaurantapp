part of 'skaleton_cubit.dart';

class SkaletonCubitState {
  final int index;
  final UserEntity? user;

  SkaletonCubitState({this.index = 0, this.user});

  SkaletonCubitState copyWith({int? index, UserEntity? user}) {
    return SkaletonCubitState(
      index: index ?? this.index,
      user: user ?? this.user,
    );
  }
}
