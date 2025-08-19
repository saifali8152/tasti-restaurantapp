import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/entities/targeted_campaign.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/usecases/add_targeted_campaign.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/usecases/init_campaign_payment.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/usecases/verify_campaign_payment.dart';
import '/core/network/response.dart';
import 'targeted_campaign_event.dart';
import 'targeted_campaign_state.dart';

class TargetedCampaignBloc extends Bloc<TargetedCampaignEvent, TargetedCampaignState> {
  final AddTargetedCampaignUsecase _addUsecase;
  final InitCampaignPaymentUsecase _initPaymentUsecase;
  final VerifyCampaignPaymentUsecase _verifyPaymentUsecase;

  TargetedCampaignBloc(
    this._addUsecase,
    this._initPaymentUsecase,
    this._verifyPaymentUsecase,
  ) : super(TargetedCampaignState(
          initPaymentResponse: ApiResponse.initial(),
          addResponse: ApiResponse.initial(),
          verifyPaymentResponse: ApiResponse.initial(),
        )) {
    on<AddTargetedCampaignEvent>(_onAddTargetedCampaignEvent);
    on<InitCampaignPayment>(_onInitCampaignPayment);
    on<VerifyCampaignPayment>(_onVerifyCampaignPayment);
  }

  Future<void> _onAddTargetedCampaignEvent(
      AddTargetedCampaignEvent event, Emitter<TargetedCampaignState> emit) async {
    emit(state.copyWith(addResponse: ApiResponse.loading()));
    try {
      final result = await _addUsecase.call(event.parms);
      if (result is DataSuccess<TargetedCampaignEntity>) {
        emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<TargetedCampaignEntity>) {
        emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(addResponse: ApiResponse.error(e.toString())));
    }
  }
  
  Future<void> _onVerifyCampaignPayment(
      VerifyCampaignPayment event, Emitter<TargetedCampaignState> emit) async {
    emit(state.copyWith(verifyPaymentResponse: ApiResponse.loading()));
    try {
      final result = await _verifyPaymentUsecase.call(event.parms);
      if (result is DataSuccess<String>) {
        emit(state.copyWith(verifyPaymentResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(verifyPaymentResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(verifyPaymentResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onInitCampaignPayment(
      InitCampaignPayment event, Emitter<TargetedCampaignState> emit) async {
    emit(state.copyWith(initPaymentResponse: ApiResponse.loading()));

    try {
      final result = await _initPaymentUsecase(event.bundleId.toString());

      if (result is DataSuccess<InitPaymentEntity>) {
        emit(state.copyWith(initPaymentResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<InitPaymentEntity>) {
        emit(state.copyWith(initPaymentResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(initPaymentResponse: ApiResponse.error(e.toString())));
    }
  }
}
