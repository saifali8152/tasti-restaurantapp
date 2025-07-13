// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/features/auth/domain/usecases/forgot_password.dart';
// import '/core/network/response.dart';
// import 'forgot_password_event.dart';
// import 'forgot_password_state.dart';

// class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
//   final ForgotPasswordUsecase _forgotPasswordUsecase;

//   ForgotPasswordBloc(this._forgotPasswordUsecase) : super(ForgotPasswordInitial()) {
//     on<ForgotPasswordRequested>(_onForgotPasswordRequested);
//   }

//   Future<void> _onForgotPasswordRequested(
//     ForgotPasswordRequested event,
//     Emitter<ForgotPasswordState> emit,
//   ) async {
//     emit(ForgotPasswordLoading());

//     try {
//       final result = await _forgotPasswordUsecase.call(event.email);

//       if (result is DataSuccess) {
//         emit(ForgotPasswordSuccess());
//       } else if (result is DataFailure<String>) {
//         emit(ForgotPasswordError(result.error.toString()));
//       }
//     } catch (e) {
//       emit(ForgotPasswordError(e.toString()));
//     }
//   }
// }
