import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/usecases/fetch_campaigns_by_res.dart';
import '/core/network/response.dart';
import 'campaign_by_res_event.dart';
import 'campaign_by_res_state.dart';

class CampaignByResBloc extends Bloc<CampaignByResEvent, CampaignByResState> {
  final FetchCampaignsByResUsecase _useCase;

  CampaignByResBloc(this._useCase)
      : super(CampaignByResState(fetchResponse: ApiResponse.initial())) {
    on<FetchCampaignsByRes>(_onFetchCampaignsByRess);
  }

  Future<void> _onFetchCampaignsByRess(
      FetchCampaignsByRes event, Emitter<CampaignByResState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final id = event.id;
      final result = await _useCase.call(id);

      if (result is DataSuccess<List<CampaignsByResEntity>>) {
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<List<CampaignsByResEntity>>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }
}
