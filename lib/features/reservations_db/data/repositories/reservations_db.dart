import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations_db/data/data_sources/reservations_db_remote_repo.dart';
import 'package:tasti_restaurant_app/features/reservations_db/data/models/restaurant_campaign.dart';
import '../../domain/repositories/reservations_db.dart';
import '/core/network/response.dart';

class ReservationDbRepoImpl extends IReservationDbRepo {
  final IReservationDbRemoteApi remote;
  ReservationDbRepoImpl(this.remote);

  @override
  Future<DataState<List<RestaurantCampaignModel>>> fetchRestaurantCampaigns(String id) async {
    try {
      final result = await remote.fetchRestaurantCampaigns(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> importCSVFile(ImportCSVFileParms parms) async {
    try {
      final result = await remote.importCSVFile(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
