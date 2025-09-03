import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/usecases/add_admin_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/usecases/delete_admin_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/usecases/fetch_admin_user.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/bloc/admin_user_event.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/bloc/admin_user_state.dart';
import '/core/network/response.dart';

class AdminUserBloc
    extends Bloc<AdminUserEvent, AdminUserState> {
  final AddAdminUserUsecase _addUsecase;
  final FetchAdminUserUsecase _fetchUsecase;
  final DeleteAdminUserUsecase _deleteUsecase;

  AdminUserBloc(
    this._addUsecase,
    this._fetchUsecase,
    this._deleteUsecase,
  ) : super(AdminUserState(
            addResponse: ApiResponse.initial(),
            fetchResponse: ApiResponse.initial(),
            updateResponse: ApiResponse.initial(),
            deleteResponse: ApiResponse.initial())) {
    on<AddAdminUserEvent>(_onAddAdminUserEvent);
    on<UpdateAdminUserEvent>(_onUpdateAdminUserEvent);
    on<FetchAdminUserEvent>(_onFetchAdminUserEvent);
    on<DeleteAdminUserEvent>(_onDeleteAdminUserEvent);
  }

  Future<void> _onDeleteAdminUserEvent(
      DeleteAdminUserEvent event, Emitter<AdminUserState> emit) async {
    emit(state.copyWith(deleteResponse: ApiResponse.loading()));
    final result = await _deleteUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        final updatedData = state.fetchResponse.data
            ?.where((seatingArea) => seatingArea.id != event.parms.id)
            .toList();
        emit(state.copyWith(
          deleteResponse: ApiResponse.completed(result.data),
          fetchResponse: ApiResponse.completed(updatedData),
        ));
        break;
      case DataFailure():
        emit(state.copyWith(deleteResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(deleteResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onAddAdminUserEvent(
      AddAdminUserEvent event, Emitter<AdminUserState> emit) async {
    emit(state.copyWith(addResponse: ApiResponse.loading()));
    final result = await _addUsecase(event.parms);

    switch (result) {
      case DataSuccess<AdminUserEntity>():
        emit(state.copyWith(
          addResponse: ApiResponse.completed(result.data),
          fetchResponse: ApiResponse.completed(
            [result.data, ...state.fetchResponse.data ?? []],
          ),
        ));
        break;
      case DataFailure():
        emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(addResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onUpdateAdminUserEvent(UpdateAdminUserEvent event,
      Emitter<AdminUserState> emit) async {
    emit(state.copyWith(updateResponse: ApiResponse.loading()));
    final result = await _addUsecase(event.parms);

    switch (result) {
      case DataSuccess<AdminUserEntity>():
        final updatedList = [
          for (final u
              in (state.fetchResponse.data ?? <AdminUserEntity>[]))
            if (u.id == result.data.id) result.data else u
        ];

        emit(state.copyWith(
          updateResponse: ApiResponse.completed(result.data),
          fetchResponse: ApiResponse.completed(updatedList),
        ));
        break;
      case DataFailure():
        emit(state.copyWith(updateResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(updateResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchAdminUserEvent(
      FetchAdminUserEvent event, Emitter<AdminUserState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<List<AdminUserEntity>>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }
}
