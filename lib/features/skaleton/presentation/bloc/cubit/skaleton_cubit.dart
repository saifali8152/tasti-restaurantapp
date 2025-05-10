import 'package:flutter_bloc/flutter_bloc.dart';

part 'skaleton_cubit_state.dart';

class SkaletonCubit extends Cubit<SkaletonCubitState> {
  SkaletonCubit() : super(SkaletonCubitState(index: 0));

  void changeTab(int newIndex) {
    emit(SkaletonCubitState(index: newIndex));
  }
}

