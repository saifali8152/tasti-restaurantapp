import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/entities/admin_sms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/fetch_admin_sms_bundle.dart';
import '/core/network/response.dart';
import 'get_admin_sms_event.dart';
import 'get_admin_sms_state.dart';

class FetchAdminSmsBloc
    extends Bloc<FetchAdminSmsEvent, GetFetchAdminSmsState> {
  final FetchAdminSmsBundleUsecase _useCase;

  FetchAdminSmsBloc(this._useCase) : super(FetchAdminSmsInitial()) {
    on<FetchInitialAdminSms>(_onFetchInitialAdminSms);
    on<FetchMoreAdminSms>(_onFetchMoreAdminSms);
  }

  Future<void> _onFetchInitialAdminSms(FetchInitialAdminSms event,
      Emitter<GetFetchAdminSmsState> emit) async {
    emit(FetchAdminSmsLoading());

    try {
      final parms = PaginationParms(
        page: '1',
        search: '',
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<AdminSmsEntity>) {
        emit(FetchAdminSmsLoaded(data: result.data.data, pagination: result.data.pagination));
      } else if (result is DataFailure<AdminSmsEntity>) {
        emit(FetchAdminSmsError(result.error.toString()));
      }
    } catch (e) {
      emit(FetchAdminSmsError(e.toString()));
    }
  }

  Future<void> _onFetchMoreAdminSms(FetchMoreAdminSms event,
      Emitter<GetFetchAdminSmsState> emit) async {
    final currentState = state;

    if (currentState is FetchAdminSmsLoaded &&
        currentState.pagination.hasNext &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final nextPage = currentState.pagination.currentPage + 1;
        final parms = PaginationParms(
          page: nextPage.toString(),
        );
        final result = await _useCase.call(parms);

        if (result is DataSuccess<AdminSmsEntity>) {
          final newData = result.data;

          final updatedList = List<AdminSmsItem>.from(currentState.data)
            ..addAll(newData.data);

          emit(FetchAdminSmsLoaded(
            data: updatedList,
            pagination: newData.pagination,
            isLoadingMore: false,
          ));
        } else if (result is DataFailure<AdminSmsEntity>) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }
}
