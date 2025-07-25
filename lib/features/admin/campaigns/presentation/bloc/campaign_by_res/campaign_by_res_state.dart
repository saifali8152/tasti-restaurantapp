import '/core/network/response.dart';
import '/features/admin/campaigns/domain/entities/campaigns_by_res.dart';

class CampaignByResState {
  final ApiResponse<List<CampaignsByResEntity>> fetchResponse;
  final ApiResponse<String> approveResponse;

  CampaignByResState({
    required this.fetchResponse,
    required this.approveResponse,
  });

  CampaignByResState copyWith({
    ApiResponse<List<CampaignsByResEntity>>? fetchResponse,
    final ApiResponse<String>? approveResponse,
  }) {
    return CampaignByResState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      approveResponse: approveResponse ?? this.approveResponse,
    );
  }
}
