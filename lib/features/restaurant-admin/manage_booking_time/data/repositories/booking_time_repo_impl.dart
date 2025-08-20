import '/features/restaurant-admin/manage_booking_time/data/models/booking_time.dart';
import '/core/parms/parms.dart';
import '../data_sources/booking_time.dart';
import '../../domain/repositories/booking_time.dart';
import '/core/network/response.dart';

class BookingTimeRepoImpl extends IBookingTimeRepo {
  final IBookingTimeRemoteApi remote;
  BookingTimeRepoImpl(this.remote);

  @override
  Future<DataState<BookingTimeModel>> fetchTimes(String id) async {
    try {
      final result = await remote.fetchTimes(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  @override
  Future<DataState<String>> activateTime(ActivateDeactivateTimeParms parms)async {
    try {
      final result = await remote.activateTime(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> deactivateTime(ActivateDeactivateTimeParms parms)async {
    try {
      final result = await remote.deactivateTime(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
  
  @override
  Future<DataState<String>> updateDuration(UpdateDurationParms parms)async {
    try {
      final result = await remote.updateTimeDuration(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
