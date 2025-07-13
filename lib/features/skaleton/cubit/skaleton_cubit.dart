import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';

part 'skaleton_cubit_state.dart';

class SkaletonCubit extends Cubit<SkaletonCubitState> {
  SkaletonCubit() : super(SkaletonCubitState(index: 0));

  void changeTab(int newIndex) {
    emit(SkaletonCubitState(index: newIndex));
  }

  void setUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void clearUser() {
    emit(state.copyWith(user: null));
  }
}
