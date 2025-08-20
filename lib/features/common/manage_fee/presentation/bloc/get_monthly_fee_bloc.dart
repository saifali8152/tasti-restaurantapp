import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '/features/common/manage_fee/domain/entities/initialize_payment.dart';
import '/features/common/manage_fee/domain/usecases/initialize_payment_fee.dart';
import '/features/common/manage_fee/domain/usecases/verify_payment.dart';
import '/features/common/auth/data/models/user.dart';
import '/features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/core/parms/parms.dart';
import '../../domain/entities/monthly_fee.dart';
import '../../domain/usecases/fetch_admin_fee.dart';
import '../../domain/usecases/update_fee.dart';
import '/core/network/response.dart';
import 'get_monthly_fee_event.dart';
import 'get_monthly_fee_state.dart';

class AdminMonthlyFeeBloc extends Bloc<MonthlyFeeEvents, MonthlyFeeState> {
  final FetchAdminMonthlyFeeUsecase _useCase;
  final UpdateAdminMonthlyFeeUsecdase _updateUsecase;
  final InitializePaymentFeeUsecase _initPaymentUsecase;
  final VerifyPaymentUsecase _verifyPaymentUsecase;

  AdminMonthlyFeeBloc(this._useCase, this._updateUsecase, this._initPaymentUsecase, this._verifyPaymentUsecase)
      : super(MonthlyFeeState(
          fetchResponse: ApiResponse.initial(),
          initResponse: ApiResponse.initial(),
          updateResponse: ApiResponse.initial(),
          verifyResponse: ApiResponse.initial(),
        )) {
    on<FetchMonthlyFeeSubmitted>(_onFetchMonthlyFeeSubmitted);
    on<UpdateMonthlyFeeSubmitted>(_onUpdateMonthlyFee);
    on<InitPaymentSubmitted>(_onInitPaymentSubmitted);
    on<VerifyPaymentSubmitted>(_onVerifyPaymentSubmitted);
  }

  Future<void> _onInitPaymentSubmitted(
      InitPaymentSubmitted event, Emitter<MonthlyFeeState> emit) async {
    emit(state.copyWith(initResponse: ApiResponse.loading()));

    try {
      final result = await _initPaymentUsecase(event.amount);

      if (result is DataSuccess<InitializePaymentEntity>) {
        emit(state.copyWith(initResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<InitializePaymentEntity>) {
        emit(state.copyWith(initResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(initResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onUpdateMonthlyFee(
      UpdateMonthlyFeeSubmitted event, Emitter<MonthlyFeeState> emit) async {
    emit(state.copyWith(updateResponse: ApiResponse.loading()));

    final params = UpdateMonthlyFeeParms(
      id: event.parms.id,
      money: event.parms.money,
    );

    try {
      final result = await _updateUsecase(params);

      if (result is DataSuccess<String>) {
        // Fetch the updated fee after successful update
        final fetchResult = await _useCase.call(null);

        if (fetchResult is DataSuccess<MonthlyFeeEntity>) {
          emit(state.copyWith(
            updateResponse: ApiResponse.completed(result.data),
            fetchResponse: ApiResponse.completed(fetchResult.data),
          ));
        } else if (fetchResult is DataFailure<MonthlyFeeEntity>) {
          emit(state.copyWith(
            updateResponse: ApiResponse.completed(result.data),
            fetchResponse: ApiResponse.error(fetchResult.error),
          ));
        }
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(updateResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(updateResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchMonthlyFeeSubmitted(
      FetchMonthlyFeeSubmitted event, Emitter<MonthlyFeeState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final result = await _useCase.call(null);
      if (result is DataSuccess<MonthlyFeeEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<MonthlyFeeEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }
  
  Future<void> _onVerifyPaymentSubmitted(
      VerifyPaymentSubmitted event, Emitter<MonthlyFeeState> emit) async {
    emit(state.copyWith(verifyResponse: ApiResponse.loading()));
    try {
      final result = await _verifyPaymentUsecase.call(event.reference);
      if (result is DataSuccess<UserModel>) {
        
        await SessionController().saveUserSession(result.data.toEntity());
        sl<UserCubit>().setUser(result.data.toEntity());

        emit(state.copyWith(verifyResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<UserModel>) {
        emit(state.copyWith(verifyResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(verifyResponse: ApiResponse.error(e.toString())));
    }
  }
}
