import 'dart:async';
import 'dart:convert';
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

  /// Validates if the response is valid JSON and contains expected structure
  dynamic _validateAndParseResponse(Response response) {
    try {
      // Check if response data is null or empty
      if (response.data == null) {
        log('Response data is null');
        throw FetchDataException('Server returned empty response');
      }

      // Check content type to ensure it's JSON
      final contentType = response.headers.value('content-type')?.toLowerCase();
      if (contentType != null && !contentType.contains('application/json')) {
        log('Non-JSON response received. Content-Type: $contentType');
        log('Response data: ${response.data}');
        
        // If it's HTML (common when service is down)
        if (contentType.contains('text/html')) {
          throw ServiceUnavailableException('Service is temporarily unavailable. Please try again later.');
        }
        
        throw FetchDataException('Server returned unexpected response format');
      }

      // If response.data is already parsed (Dio does this automatically for JSON)
      if (response.data is Map || response.data is List) {
        return response.data;
      }

      // If response.data is a string, try to parse it as JSON
      if (response.data is String) {
        try {
          return json.decode(response.data);
        } catch (e) {
          log('Failed to parse response as JSON: $e');
          log('Raw response: ${response.data}');
          throw FetchDataException('Server returned invalid JSON response');
        }
      }

      // For any other type, log and throw error
      log('Unexpected response data type: ${response.data.runtimeType}');
      log('Response data: ${response.data}');
      throw FetchDataException('Server returned unexpected response type');

    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }
      log('Error validating response: $e');
      throw FetchDataException('Failed to process server response');
    }
  }

  /// Enhanced response handler with validation
  dynamic _handleValidatedResponse(Response response) {
    try {
      final validatedData = _validateAndParseResponse(response);
      return handleResponse(Response(
        data: validatedData,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        headers: response.headers,
        requestOptions: response.requestOptions,
      ));
    } catch (e) {
      log('Error in response validation: $e');
      rethrow;
    }
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
            options: Options(
              headers: headers,
              responseType: ResponseType.plain, // Get raw response first
            ),
          )
          .timeout(const Duration(seconds: 20));
      
      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers.map}');
      
      return _handleValidatedResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }
      log('Unexpected error in GET: $e');
      throw FetchDataException('Unable to connect to server. Please check your connection and try again.');
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
            options: Options(
              headers: headers,
              responseType: ResponseType.plain, // Get raw response first
            ),
          )
          .timeout(const Duration(seconds: 20));
      
      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers.map}');

      return _handleValidatedResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }
      log('Unexpected error in POST: $e');
      throw FetchDataException('Unable to connect to server. Please check your connection and try again.');
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
            options: Options(
              headers: headers,
              responseType: ResponseType.plain, // Get raw response first
            ),
          )
          .timeout(const Duration(seconds: 20));

      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers.map}');

      return _handleValidatedResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }
      log('Unexpected error in POST MULTIPART: $e');
      throw FetchDataException('Unable to upload files. Please check your connection and try again.');
    }
  }

  Exception _handleDioError(DioException dioError) {
    log('DioError: ${dioError.response} ${dioError.requestOptions.uri}');
    log('DioError type: ${dioError.type}');
    log('DioError message: ${dioError.message}');
    
    // Handle connection errors
    if (dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.sendTimeout ||
        dioError.type == DioExceptionType.receiveTimeout) {
      return TimeoutException('Connection timeout. Please check your internet connection.');
    }
    
    if (dioError.type == DioExceptionType.connectionError) {
      return FetchDataException('Unable to connect to server. Please check your internet connection.');
    }
    
    if (dioError.response != null) {
      final status = dioError.response?.statusCode;
      
      // Try to extract error message safely
      String msg = 'Something went wrong.';
      try {
        final responseData = dioError.response?.data;
        if (responseData != null) {
          if (responseData is Map<String, dynamic>) {
            msg = responseData['message']?.toString() ?? 
                  responseData['error']?.toString() ?? 
                  responseData['msg']?.toString() ?? 
                  'Something went wrong.';
          } else if (responseData is String) {
            // Check if it's HTML error page
            if (responseData.toLowerCase().contains('<html>') || 
                responseData.toLowerCase().contains('<!doctype')) {
              msg = 'Service is temporarily unavailable. Please try again later.';
            } else {
              // Try to parse as JSON
              try {
                final parsed = json.decode(responseData);
                if (parsed is Map<String, dynamic>) {
                  msg = parsed['message']?.toString() ?? 
                        parsed['error']?.toString() ?? 
                        parsed['msg']?.toString() ?? 
                        'Something went wrong.';
                }
              } catch (_) {
                msg = 'Server returned an unexpected response.';
              }
            }
          }
        }
      } catch (e) {
        log('Error extracting error message: $e');
        msg = 'Something went wrong.';
      }

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
        case 502:
        case 503:
        case 504:
          return ServiceUnavailableException('Service is temporarily unavailable. Please try again later.');
        default:
          return FetchDataException('Server error (Status: $status). Please try again later.');
      }
    } else {
      return FetchDataException('No response from server. Please check your internet connection.');
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
            options: Options(
              headers: headers,
              responseType: ResponseType.plain, // Get raw response first
            ),
          )
          .timeout(const Duration(seconds: 20));

      log('Response status: ${response.statusCode}');
      log('Response headers: ${response.headers.map}');
      
      return _handleValidatedResponse(response);
    } on TimeoutException {
      throw TimeoutException('Request timed out. Please try again.');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }
      log('Unexpected error in DELETE: $e');
      throw FetchDataException('Unable to connect to server. Please check your connection and try again.');
    }
  }
}