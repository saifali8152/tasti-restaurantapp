import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import '/dependency_injection.dart';
import '/core/services/session_controller.dart';
import '/core/error/exception.dart';
import '/core/network/api_services.dart';
import '/core/network/network_utils.dart';
import '/core/services/navigator_services.dart';

class NetworkApiServiceImpl implements IApiService {
  final Dio dio;

  NetworkApiServiceImpl(this.dio);

  Map<String, String> _buildHeaders() {
    final token = sl<SessionController>().user?.token;
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  @override
  Future get(
    String url, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final headers = _buildHeaders();

      log('GET $uri');
      log('Query Params: $queryParams');

      final response = await dio
          .get(
            uri.toString(),
            queryParameters: queryParams,
            options: Options(headers: headers),
          )
          .timeout(const Duration(seconds: 20));
      log('Response: $response');
      return handleResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      log('Unexpected error: $e');
      throw FetchDataException('Unexpected error occurred.');
    }
  }

  @override
  Future post(String url, dynamic data) async {
    try {
      final headers = _buildHeaders();

      log('POST $url');
      log('Body: $data');
      log('Headers: $headers');
      log('Token: ${sl<SessionController>().user?.token}');

      final response = await dio
          .post(
            url,
            data: data,
            options: Options(headers: headers),
          )
          .timeout(const Duration(seconds: 20));
      log('Response: $response');

      return handleResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      log('Unexpected error: $e');
      throw FetchDataException('Unexpected error occurred.');
    }
  }

  @override
  Future postMultipart(
    String url,
    Map<String, dynamic> fields,
    Map<String, MultipartFile> files,
  ) async {
    try {
      final headers = _buildHeaders();

      final formData = FormData();
      fields.forEach(
          (key, value) => formData.fields.add(MapEntry(key, value.toString())));
      files.forEach((key, file) => formData.files.add(MapEntry(key, file)));

      log('POST MULTIPART $url');
      log('Fields: $fields');
      log('Files: $files');

      final response = await dio
          .post(
            url,
            data: formData,
            options: Options(headers: headers),
          )
          .timeout(const Duration(seconds: 20));

      log('Response: $response');

      return handleResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      log('Unexpected error: $e');
      throw FetchDataException('Unexpected error occurred.');
    }
  }

  Exception _handleDioError(DioException dioError) {
    log('DioError: ${dioError.response} ${dioError.requestOptions.uri}');
    if (dioError.response != null) {
      final status = dioError.response?.statusCode;
      final msg = dioError.response?.data['message'] ?? 'Something went wrong.';

      switch (status) {
        case 400:
          return BadRequestException(msg);
        case 401:
          return UnauthorizedException(msg);
        case 403:
          Future.microtask(() {
            if(SessionController().user?.type == "restaurant_user"){
              return NavigatorService.clearSessionAndnavigate();
            }
            if(SessionController().user?.type == "restaurant"){
              return NavigatorService.navigateToRemoveUntill(AppRoutes.monthlyFee);
            }
          });

          return UnauthorizedException(msg);
        case 404:
          return NotFoundException(msg);
        case 409:
          return ConflictException(msg);
        case 500:
          return InternalServerErrorException(msg);
        default:
          return FetchDataException('Unknown error with status: $status');
      }
    } else {
      return FetchDataException('No response from server.');
    }
  }

  @override
  Future delete(
    String url, {
    Map<String, String>? queryParams,
    dynamic data,
  }) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      final headers = _buildHeaders();

      log('DELETE $uri');
      log('Query Params: $queryParams');
      if (data != null) log('Body: $data');

      final response = await dio
          .delete(
            uri.toString(),
            data: data,
            options: Options(headers: headers),
          )
          .timeout(const Duration(seconds: 20));

      log('Response: $response');
      return handleResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      log('Unexpected error: $e');
      throw FetchDataException('Unexpected error occurred.');
    }
  }
}
