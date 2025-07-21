import 'package:tasti_restaurant_app/features/admin/today_queries/data/models/today_queries.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ITodayQueriesRemoteSourceApi {
  Future<TodayQueriesModel> fetchTodayQueries(PaginationParms parms);
  Future<String> deleteTodayQueries(String parms);
  Future<String> replyTodayQuery(ReplyTodayQueryParms parms);
}

class TodayQueriesSourceRemoteApiImpl extends ITodayQueriesRemoteSourceApi {
  final IApiService networkApiService;
  TodayQueriesSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> deleteTodayQueries(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "req_id": id,
    };
    var response =
        await networkApiService.post(AppUrls.adminDeleteTodayQuery, data);

    return response['message'];
  }
 
  @override
  Future<String> replyTodayQuery(ReplyTodayQueryParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "req_id": parms.id,
      "reply": parms.message,
    };
    var response =
        await networkApiService.post(AppUrls.adminReplyTodayQuery, data);

    return response['message'];
  }

  @override
  Future<TodayQueriesModel> fetchTodayQueries(PaginationParms parms) async {
    Map<String, String> data = {};

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
      "search": parms.search.toString(),
    };
    final response =
        await networkApiService.get(AppUrls.adminFetchTodayQueries, queryParams: data);
    final Map<String, dynamic> adminReservation = response;
    final TodayQueriesModel adminSmsList = TodayQueriesModel.fromJson(adminReservation);
    return adminSmsList;
  }
}
