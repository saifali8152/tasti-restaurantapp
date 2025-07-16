import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/manage_sms_bundle_discount.dart';
import 'manage_sms_bundle_discount_event.dart';
import 'manage_sms_bundle_discount_state.dart';

class ManageSmsBundleDiscountBloc
    extends Bloc<ManageSmsBundleDiscountEvents, ManageSmsBundleDiscountState> {
  final ManageSmsBundleDiscountUsecase usecase;

  ManageSmsBundleDiscountBloc(this.usecase)
      : super(ManageSmsBundleDiscountState(
            manageDiscountResponse: ApiResponse.initial())) {
    on<SetPriceEvent>((event, emit) {
      final newPrice = event.price;
      final percentage = state.percentage;

      int discount = state.discount;

      if (percentage != 0) {
        final discountValue = newPrice - (newPrice * percentage / 100);
        discount = double.parse(discountValue.toStringAsFixed(2)).toInt();
      }

      emit(state.copyWith(price: newPrice, discount: discount));
    });

    on<SetPercentageEvent>((event, emit) {
      final newPercentage = event.percentage;
      final price = state.price;

      int discount = state.discount;

      if (newPercentage != 0) {
        final discountValue = price - (price * newPercentage / 100);
        discount = double.parse(discountValue.toStringAsFixed(2)).toInt();
      } else {
        discount = 0;
      }

      emit(state.copyWith(percentage: newPercentage, discount: discount));
    });

    on<SubmitManageSmsBundleDiscountEvent>((event, emit) async {
      emit(state.copyWith(manageDiscountResponse: ApiResponse.loading()));

      final params = ManageSmsBundleDiscountParms(
        id: event.id,
        discount: state.discount,
        percentage: state.percentage,
      );

      final result = await usecase(params);

      if (result is DataSuccess<String>) {
        emit(state.copyWith(
            manageDiscountResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(
            manageDiscountResponse: ApiResponse.error(result.error)));
      }
    });
  }
}
