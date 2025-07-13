import 'package:dio/dio.dart';
import '/core/error/exception.dart';

dynamic handleResponse(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response.data;
    case 400:
      throw BadRequestException(response.data['message'] ?? 'Bad Request');
    case 401:
    case 403:
      throw UnauthorizedException(response.data['message'] ?? 'Unauthorized');
    case 404:
      throw NotFoundException(response.data['message'] ?? 'Not Found');
    case 409:
      throw ConflictException(response.data['message'] ?? 'Conflict');
    case 500:
      throw InternalServerErrorException(response.data['message'] ?? 'Server Error');
    default:
      throw FetchDataException('Unexpected status code: ${response.statusCode}');
  }
}
