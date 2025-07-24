import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/entities/campaigns_by_res.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/usecases/approve_event.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/usecases/fetch_campaigns_by_res.dart';
import '/core/network/response.dart';
import 'campaign_by_res_event.dart';
import 'campaign_by_res_state.dart';

class CampaignByResBloc extends Bloc<CampaignByResEvent, CampaignByResState> {
  final FetchCampaignsByResUsecase _useCase;
  final ApproveCampaignUsecase _approveUseCase;

  CampaignByResBloc(this._useCase, this._approveUseCase)
      : super(CampaignByResState(
          fetchResponse: ApiResponse.initial(),
          approveResponse: ApiResponse.initial(),
        )) {
    on<FetchCampaignsByRes>(_onFetchCampaignsByRess);
    on<ApproveCampaignEvent>(_onApproveCampaignEvent);
  }

  Future<void> _onApproveCampaignEvent(
      ApproveCampaignEvent event, Emitter<CampaignByResState> emit) async {
    emit(state.copyWith(approveResponse: ApiResponse.loading()));
    try {
      final result = await _approveUseCase.call(event.id.toString());
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList = oldList?.map((r) {
          if (r.cId == event.id) {
            return r.copyWith(status: 'completed');
          }
          return r;
        }).toList();

        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(List.from(optimisticList!)),
            approveResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(approveResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(approveResponse: ApiResponse.error(e.toString())));
    }
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
