import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/usecases/fetch_restaurant_campaigns.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/usecases/import_scv_file.dart';
import '/core/network/response.dart';
import 'restaurant_campaigns_event.dart';
import 'restaurant_campaigns_state.dart';

class RestaurantCampaignsBloc
    extends Bloc<RestaurantCampaignsEvent, RestaurantCampaignsState> {
  final FetchRestaurantCampaignsUsecase _fetchUsecase;
  final ImportScvFileUsecase _importUsecase;

  RestaurantCampaignsBloc(
    this._fetchUsecase,
    this._importUsecase,
  ) : super(RestaurantCampaignsState(
          fetchResponse: ApiResponse.initial(),
          importResponse: ApiResponse.initial(),
        )) {
    on<FetchRestaurantCampaignsEvent>(_onFetchRestaurantCampaignsEvent);
    on<ImportCSVFile>(_onImportCSVFile);
  }

  Future<void> _onFetchRestaurantCampaignsEvent(
      FetchRestaurantCampaignsEvent event,
      Emitter<RestaurantCampaignsState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<List<RestaurantCampaignEntity>>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }
  
  Future<void> _onImportCSVFile(
      ImportCSVFile event,
      Emitter<RestaurantCampaignsState> emit) async {
    emit(state.copyWith(importResponse: ApiResponse.loading()));
    final result = await _importUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(importResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(importResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(importResponse: ApiResponse.initial()));
    }
  }
}
