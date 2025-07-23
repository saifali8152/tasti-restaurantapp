import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/entities/campaigns_by_res.dart';

class CampaignByResState {
  final ApiResponse<List<CampaignsByResEntity>> fetchResponse;

  CampaignByResState({
    required this.fetchResponse,
  });

  CampaignByResState copyWith({
    ApiResponse<List<CampaignsByResEntity>>? fetchResponse,
  }) {
    return CampaignByResState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }
}
