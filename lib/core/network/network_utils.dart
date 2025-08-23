import 'package:dio/dio.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/core/services/navigator_services.dart';
import '/core/error/exception.dart';

dynamic handleResponse(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return response.data;
    case 400:
      throw BadRequestException(response.data['message'] ?? 'Bad Request');
    case 401:
      throw UnauthorizedException(response.data['message'] ?? 'Unauthorized');
    case 403:
      NavigatorService.navigateToRemoveUntill(AppRoutes.monthlyFee);
      throw UnauthorizedException(response.data['message'] ?? 'Unauthorized');
    case 404:
      throw NotFoundException(response.data['message'] ?? 'Not Found');
    case 409:
      throw ConflictException(response.data['message'] ?? 'Conflict');
    case 500:
      throw InternalServerErrorException(
          response.data['message'] ?? 'Server Error');
    default:
      throw FetchDataException(
          'Unexpected status code: ${response.statusCode}');
  }
}
