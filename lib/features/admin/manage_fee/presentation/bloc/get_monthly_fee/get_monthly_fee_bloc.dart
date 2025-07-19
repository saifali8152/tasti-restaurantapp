import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/monthly_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/usecases/fetch_admin_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/entities/admin_sms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/add_sms_bundle.dart';
import '/core/network/response.dart';
import 'get_monthly_fee_event.dart';
import 'get_monthly_fee_state.dart';

class AdminMonthlyFeeBloc extends Bloc<MonthlyFeeEvents, MonthlyFeeState> {
  final FetchAdminMonthlyFeeUsecase _useCase;
  final AddSMSBundleUsecase _addUsecase;

  AdminMonthlyFeeBloc(this._useCase, this._addUsecase)
      : super(MonthlyFeeState(
            fetchResponse: ApiResponse.initial(),
            addResponse: ApiResponse.initial())) {
    on<FetchMonthlyFeeSubmitted>(_onFetchMonthlyFeeSubmitted);
    on<AdminAddSmsRequested>(_onAdminAddSmsRequested);
  }

  Future<void> _onAdminAddSmsRequested(
      AdminAddSmsRequested event, Emitter<MonthlyFeeState> emit) async {
    emit(state.copyWith(addResponse: ApiResponse.loading()));

    final params = AddSMSBundleParms(
      owner: event.parms.owner,
      quantity: event.parms.quantity,
      discount: event.parms.discount,
      price: event.parms.price,
      percentage: event.parms.percentage,
    );

    final result = await _addUsecase(params);

    if (result is DataSuccess<String>) {
      final fetchParams = PaginationParms(page: '1', search: '');
      final fetchResult = await _useCase.call(fetchParams);

      if (fetchResult is DataSuccess<AdminSmsEntity>) {
        emit(state.copyWith(
          addResponse: ApiResponse.completed(result.data),
        ));
      } else if (fetchResult is DataFailure<AdminSmsEntity>) {
        emit(state.copyWith(
          addResponse:
              ApiResponse.completed(result.data), // still success for add
          fetchResponse: ApiResponse.error(fetchResult.toString()),
        ));
      }
    } else if (result is DataFailure<String>) {
      emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
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
