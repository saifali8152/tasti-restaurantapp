import 'package:equatable/equatable.dart';
import '/core/enum/restaurant_filter.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object?> get props => [];
}

class SuspendedRestaurant extends RestaurantEvent {
  final int id;

  const SuspendedRestaurant(this.id);
}

class ActivateRestaurant extends RestaurantEvent {
  final int id;

  const ActivateRestaurant(this.id);
}

class SearchRestaurant extends RestaurantEvent {
  final String query;

  const SearchRestaurant(this.query);
}

class SetRestaurantFilter extends RestaurantEvent {
  final RestaurantFilter filter;

  const SetRestaurantFilter(this.filter);
}

class FetchInitialRestaurant extends RestaurantEvent {}

class FetchMoreRestaurant extends RestaurantEvent {}
