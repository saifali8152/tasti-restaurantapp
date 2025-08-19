import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/entities/targeted_campaign.dart';
import '/core/network/response.dart';

class TargetedCampaignState extends Equatable {
  final ApiResponse<InitPaymentEntity> initPaymentResponse;
  final ApiResponse<String> verifyPaymentResponse;
  final ApiResponse<TargetedCampaignEntity> addResponse;

  const TargetedCampaignState({
    required this.initPaymentResponse,
    required this.verifyPaymentResponse,
    required this.addResponse,
  });

  TargetedCampaignState copyWith({
    final ApiResponse<String>? verifyPaymentResponse,
    final ApiResponse<TargetedCampaignEntity>? addResponse,
    final ApiResponse<InitPaymentEntity>? initPaymentResponse,
  }) {
    return TargetedCampaignState(
      verifyPaymentResponse: verifyPaymentResponse ?? ApiResponse.initial(),
      initPaymentResponse: initPaymentResponse ?? ApiResponse.initial(),
      addResponse: addResponse ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props => [
        initPaymentResponse,
        verifyPaymentResponse,
        addResponse,
      ];
}
