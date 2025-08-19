import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/restaurant_campaign.dart';
import '/core/network/response.dart';

abstract class IReservationDbRepo {
  Future<DataState<List<RestaurantCampaignEntity>>> fetchRestaurantCampaigns(String id);
  Future<DataState<String>> importCSVFile(ImportCSVFileParms parms);
  Future<DataState<List<CSVDataEntity>>> fetchCSVData(String id);
  Future<DataState<List<ReservationDataEntity>>> fetchReservations(String id);
  Future<DataState<List<ReservationDataEmailEntity>>> fetchReservationsByEmail(FetchReservationByEmailParms parms);
}
