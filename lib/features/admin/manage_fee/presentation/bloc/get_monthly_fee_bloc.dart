import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/monthly_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/usecases/fetch_admin_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/usecases/update_fee.dart';
import '/core/network/response.dart';
import 'get_monthly_fee_event.dart';
import 'get_monthly_fee_state.dart';

class AdminMonthlyFeeBloc extends Bloc<MonthlyFeeEvents, MonthlyFeeState> {
  final FetchAdminMonthlyFeeUsecase _useCase;
  final UpdateAdminMonthlyFeeUsecdase _updateUsecase;

  AdminMonthlyFeeBloc(this._useCase, this._updateUsecase)
      : super(MonthlyFeeState(
          fetchResponse: ApiResponse.initial(),
          updateResponse: ApiResponse.initial(),
        )) {
    on<FetchMonthlyFeeSubmitted>(_onFetchMonthlyFeeSubmitted);
    on<UpdateMonthlyFeeSubmitted>(_onUpdateMonthlyFee);
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
}
