import '/core/parms/parms.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/csv_data.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/reservation_data_email.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/resevation_data.dart';
import '/features/restaurant-admin/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/network/response.dart';

abstract class IReservationDbRepo {
  Future<DataState<List<RestaurantCampaignEntity>>> fetchRestaurantCampaigns(String id);
  Future<DataState<String>> importCSVFile(ImportCSVFileParms parms);
  Future<DataState<List<CSVDataEntity>>> fetchCSVData(String id);
  Future<DataState<List<ReservationDataEntity>>> fetchReservations(String id);
  Future<DataState<List<ReservationDataEmailEntity>>> fetchReservationsByEmail(FetchReservationByEmailParms parms);
  Future<DataState<String>> fetchSmsAvailability(FetchSmsAvailabilityParms parms);
  Future<DataState<String>> sendCSVData(SendCSVDataParams parms);
  Future<DataState<String>> sendRestaurantData(SendRestaurantDataParms parms);
}
