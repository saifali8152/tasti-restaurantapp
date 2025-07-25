import '/core/enum/query_type.dart';
import '/features/admin/queries/data/models/queries.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IQueriesRemoteSourceApi {
  Future<QueriesModel> fetchQueries(QueryParms parms);
  Future<String> deleteQueries(String parms);
  Future<String> replyQuery(ReplyQueryParms parms);
}

class QueriesSourceRemoteApiImpl extends IQueriesRemoteSourceApi {
  final IApiService networkApiService;
  QueriesSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> deleteQueries(String id) async {
    Map<String, dynamic> data = {};

    data = {
      "req_id": id,
    };
    var response =
        await networkApiService.post(AppUrls.adminDeleteTodayQuery, data);

    return response['message'];
  }
 
  @override
  Future<String> replyQuery(ReplyQueryParms parms) async {
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
  Future<QueriesModel> fetchQueries(QueryParms parms) async {
    Map<String, String> data = {};
    String url = parms.type == QueryType.todayQueries
        ? AppUrls.adminFetchTodayQueries
        : parms.type == QueryType.monthlyQueries
            ? AppUrls.adminFetchMonthQueries
            : parms.type == QueryType.overallQueries
                ? AppUrls.adminFetchOverallQueries
                : '';

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
      "search": parms.search.toString(),
    };
    final response =
        await networkApiService.get(url, queryParams: data);
    final Map<String, dynamic> adminReservation = response;
    final QueriesModel adminSmsList = QueriesModel.fromJson(adminReservation);
    return adminSmsList;
  }
}
