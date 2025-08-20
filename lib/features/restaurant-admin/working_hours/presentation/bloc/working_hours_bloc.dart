import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/restaurant-admin/working_hours/data/models/working_hour.dart';
import '/features/restaurant-admin/working_hours/domain/usecases/add_working_hour.dart';
import '/features/restaurant-admin/working_hours/domain/usecases/fetch_working_hour.dart';
import '/features/restaurant-admin/working_hours/domain/usecases/update_working_hour.dart';
import '/core/network/response.dart';
import 'working_hours_event.dart';
import 'working_hours_state.dart';

class WorkingHoursBloc extends Bloc<WorkingHoursEvent, WorkingHoursState> {
  final FetchWorkingHourUsecase _fetchUsecase;
  final UpdateWorkingHourUsecase _updateUsecase;
  final AddWorkingHourUsecase _addUsecase;

  WorkingHoursBloc(
    this._fetchUsecase,
    this._updateUsecase,
    this._addUsecase,
  ) : super(WorkingHoursState(
          addResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
          updateResponse: ApiResponse.initial(),
        )) {
    on<FetchWorkingHoursEvent>(_onFetchWorkingHoursEvent);
    on<UpdateWorkingHoursEvent>(_onUpdateWorkingHoursEvent);
    on<AddWorkingHoursEvent>(_onAddWorkingHoursEvent);
  }

  bool _hasAtLeastOneDay(dynamic parms) {
    return (parms.monday != null && parms.monday.isNotEmpty) ||
        (parms.tuesday != null && parms.tuesday.isNotEmpty) ||
        (parms.wednesday != null && parms.wednesday.isNotEmpty) ||
        (parms.thursday != null && parms.thursday.isNotEmpty) ||
        (parms.friday != null && parms.friday.isNotEmpty) ||
        (parms.saturday != null && parms.saturday.isNotEmpty) ||
        (parms.sunday != null && parms.sunday.isNotEmpty);
  }

  Future<void> _onAddWorkingHoursEvent(
      AddWorkingHoursEvent event, Emitter<WorkingHoursState> emit) async {
    if (!_hasAtLeastOneDay(event.parms)) {
      emit(state.copyWith(
        addResponse: ApiResponse.error('At least one day must be set'),
      ));
      return;
    }

    emit(state.copyWith(addResponse: ApiResponse.loading()));
    final result = await _addUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        add(FetchWorkingHoursEvent(event.parms.id.toString()));
        emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
        break;

      case DataFailure():
        emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
        break;

      default:
        emit(state.copyWith(addResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onUpdateWorkingHoursEvent(
      UpdateWorkingHoursEvent event, Emitter<WorkingHoursState> emit) async {
    if (!_hasAtLeastOneDay(event.parms)) {
      emit(state.copyWith(
        addResponse: ApiResponse.error('At least one day must be set'),
      ));
      return;
    }

    emit(state.copyWith(updateResponse: ApiResponse.loading()));
    final result = await _updateUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(
          state.copyWith(
            updateResponse: ApiResponse.completed(result.data),
            fetchResponse: ApiResponse.completed(
              state.fetchResponse.data?.copyWith(
                monday: event.parms.monday.isEmpty? "Closed" : event.parms.monday,
                tuesday: event.parms.tuesday.isEmpty? "Closed" : event.parms.tuesday,
                wednesday: event.parms.wednesday.isEmpty? "Closed" : event.parms.wednesday,
                thursday: event.parms.thursday.isEmpty? "Closed" : event.parms.thursday,
                friday: event.parms.friday.isEmpty? "Closed" : event.parms.friday,
                saturday: event.parms.saturday.isEmpty? "Closed" : event.parms.saturday,
                sunday: event.parms.sunday.isEmpty? "Closed" : event.parms.sunday,
              ),
            ),
          ),
        );
        break;
      case DataFailure():
        emit(state.copyWith(updateResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(updateResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchWorkingHoursEvent(
      FetchWorkingHoursEvent event, Emitter<WorkingHoursState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<WorkingHourModel>():
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
