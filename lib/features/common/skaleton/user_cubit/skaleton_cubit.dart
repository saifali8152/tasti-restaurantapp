import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/domain/entities/user.dart';

part 'skaleton_cubit_state.dart';

class UserCubit extends Cubit<UserCubitState> {
  UserCubit() : super(UserCubitState());

  void setUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void clearUser() {
    emit(state.copyWith(user: null));
  }
}
