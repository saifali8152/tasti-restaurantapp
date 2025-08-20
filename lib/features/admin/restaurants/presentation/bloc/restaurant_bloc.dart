import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/enum/restaurant_filter.dart';
import '/features/admin/restaurants/domain/entities/restaurant.dart';
import '/features/admin/restaurants/domain/usecases/active_restaurant.dart';
import '/features/admin/restaurants/domain/usecases/fetch_restaurant.dart';
import '/features/admin/restaurants/domain/usecases/suspend_restaurant.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';
import 'restaurant_event.dart';
import 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final FetchRestaurantUsecase _useCase;
  final ActiveRestaurantUsecase _activateUsecase;
  final SuspendRestaurantUsecase _suspendUsecase;

  RestaurantBloc(
    this._useCase,
    this._suspendUsecase,
    this._activateUsecase,
  ) : super(RestaurantState(
          fetchResponse: ApiResponse.initial(),
          suspendResponse: ApiResponse.initial(),
          activateResponse: ApiResponse.initial(),
          filter: RestaurantFilter.all,
        )) {
    on<FetchInitialRestaurant>(_onFetchInitialRestaurant);
    on<FetchMoreRestaurant>(_onFetchMoreRestaurant);
    on<SearchRestaurant>(_onSearchRestaurant);
    on<SuspendedRestaurant>(_onSuspendedRestaurant);
    on<ActivateRestaurant>(_onActivateRestaurant);
    on<SetRestaurantFilter>(_onSetRestaurantFilter);
  }

  Future<void> _onActivateRestaurant(
      ActivateRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(activateResponse: ApiResponse.loading()));
    try {
      final result = await _activateUsecase.call(event.id.toString());
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList = oldList?.map((r) {
          if (r.id == event.id) {
            return r.copyWith(
                status: 'Active');
          }
          return r;
        }).toList();

        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(List.from(optimisticList!)),
            activateResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(activateResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(activateResponse: ApiResponse.error(e.toString())));
    }
  }
  
  Future<void> _onSuspendedRestaurant(
      SuspendedRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(suspendResponse: ApiResponse.loading()));
    try {
      final result = await _suspendUsecase.call(event.id.toString());
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList = oldList?.map((r) {
          if (r.id == event.id) {
            return r.copyWith(status: 'suspended');
          }
          return r;
        }).toList();

        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(List.from(optimisticList!)),
            suspendResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(suspendResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(suspendResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchInitialRestaurant(
      FetchInitialRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms =
          AllRestaurantParms(search: state.query, filter: state.filter.value);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<RestaurantEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<RestaurantEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onSearchRestaurant(
      SearchRestaurant event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading(), query: event.query));

    try {
      final parms =
          AllRestaurantParms(search: event.query, filter: state.filter.value);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<RestaurantEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<RestaurantEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }
  
  Future<void> _onSetRestaurantFilter(
      SetRestaurantFilter event, Emitter<RestaurantState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading(), filter: event.filter));

    try {
      final parms = AllRestaurantParms(search: state.query, filter: event.filter.value);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<RestaurantEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<RestaurantEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchMoreRestaurant(
      FetchMoreRestaurant event, Emitter<RestaurantState> emit) async {
    if (state.pagination!.hasNext && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      try {
        final nextPage = state.pagination!.currentPage + 1;
        final parms = AllRestaurantParms(
            page: nextPage.toString(),
            search: state.query,
            filter: state.filter.value);
        final result = await _useCase.call(parms);

        if (result is DataSuccess<RestaurantEntity>) {
          final newData = result.data;

          final updatedList =
              List<RestaurantItem>.from(state.fetchResponse.data!)
                ..addAll(newData.data);

          emit(state.copyWith(
              fetchResponse: ApiResponse.completed(updatedList),
              pagination: newData.pagination,
              isLoadingMore: false));
        } else if (result is DataFailure<RestaurantEntity>) {
          emit(state.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingMore: false));
      }
    }
  }
}
