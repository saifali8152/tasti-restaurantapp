part of 'download_cubit.dart';

abstract class RestaurantQrState {}

class RestaurantQrInitial extends RestaurantQrState {}
class RestaurantQrDownloading extends RestaurantQrState {}
class RestaurantQrDownloaded extends RestaurantQrState {}
class RestaurantQrError extends RestaurantQrState {
  final String message;
  RestaurantQrError(this.message);
}
