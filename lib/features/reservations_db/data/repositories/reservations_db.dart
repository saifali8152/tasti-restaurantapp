import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations_db/data/data_sources/reservations_db_remote_repo.dart';
import 'package:tasti_restaurant_app/features/reservations_db/data/models/restaurant_campaign.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import '../../domain/repositories/reservations_db.dart';
import '/core/network/response.dart';

class ReservationDbRepoImpl extends IReservationDbRepo {
  final IReservationDbRemoteApi remote;
  ReservationDbRepoImpl(this.remote);

  @override
  Future<DataState<String>> fetchSmsAvailability(
      FetchSmsAvailabilityParms parms) async {
    try {
      final result = await remote.fetchSmsAvailability(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<RestaurantCampaignModel>>> fetchRestaurantCampaigns(
      String id) async {
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

  @override
  Future<DataState<List<CSVDataEntity>>> fetchCSVData(String id) async {
    try {
      final result = await remote.fetchCSVData(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<ReservationDataEntity>>> fetchReservations(
      String id) async {
    try {
      final result = await remote.fetchReservations(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<List<ReservationDataEmailEntity>>> fetchReservationsByEmail(
      FetchReservationByEmailParms parms) async {
    try {
      final result = await remote.fetchReservationsByEmail(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> sendCSVData(SendCSVDataParams parms)async {
    try {
      final result = await remote.sendCSVData(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> sendRestaurantData(SendRestaurantDataParms parms)async{
    try {
      final result = await remote.sendRestaurantData(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
