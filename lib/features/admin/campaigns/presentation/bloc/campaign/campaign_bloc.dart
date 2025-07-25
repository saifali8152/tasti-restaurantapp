import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/admin/campaigns/domain/entities/campaigns.dart';
import '/features/admin/campaigns/domain/usecases/fetch_campaigns.dart';
import '/core/network/response.dart';
import 'campaign_event.dart';
import 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final FetchCampaignsUsecase _useCase;

  CampaignBloc(this._useCase)
      : super(CampaignState(fetchResponse: ApiResponse.initial())) {
    on<FetchCampaigns>(_onFetchCampaignss);
  }

  Future<void> _onFetchCampaignss(
      FetchCampaigns event, Emitter<CampaignState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final result = await _useCase.call(null);

      if (result is DataSuccess<List<CampaignsEntity>>) {
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<List<CampaignsEntity>>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }
}
