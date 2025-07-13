import 'package:dio/dio.dart';

abstract class IApiService {
  Future<dynamic> get(String url, {
    Map<String, String>? queryParams,
  });

  Future<dynamic> post(String url, dynamic data);

  Future<dynamic> postMultipart(
    String url,
    Map<String, dynamic> fields,
    Map<String, MultipartFile> files,
  );
}
