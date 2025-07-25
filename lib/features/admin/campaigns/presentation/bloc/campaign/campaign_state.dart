import '/core/network/response.dart';
import '/features/admin/campaigns/domain/entities/campaigns.dart';

class CampaignState {
  final ApiResponse<List<CampaignsEntity>> fetchResponse;

  CampaignState({
    required this.fetchResponse,
  });

  CampaignState copyWith({
    ApiResponse<List<CampaignsEntity>>? fetchResponse,
  }) {
    return CampaignState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }
}
