// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/core/network/response.dart';
// import '/core/parms/parms.dart';
// import '/features/admin/manage_sms/domain/usecases/add_sms_bundle.dart';
// import 'add_sms_bundle_event.dart';
// import 'add_sms_bundle_state.dart';

// class AddSmsBundleBloc extends Bloc<AddSmsBundleEvent, AddSmsBundleState> {
//   final AddSMSBundleUsecase addSmsBundleUseCase;

//   AddSmsBundleBloc(this.addSmsBundleUseCase)
//       : super(AddSmsBundleState(addResposne: ApiResponse.initial())) {
//     on<SetOwnerEvent>((event, emit) {
//       emit(state.copyWith(owner: event.owner));
//     });

//     on<SetQuantityEvent>((event, emit) {
//       emit(state.copyWith(quantity: event.quantity));
//     });

//     on<SetDiscountEvent>((event, emit) {
//       emit(state.copyWith(discount: event.discount));
//     });

//     on<SetPriceEvent>((event, emit) {
//       final newPrice = event.price;
//       final percentage = state.percentage;

//       int discount = state.discount;

//       if (percentage != 0) {
//         final discountValue = newPrice - (newPrice * percentage / 100);
//         discount = double.parse(discountValue.toStringAsFixed(2)).toInt();
//       }

//       emit(state.copyWith(price: newPrice, discount: discount));
//     });

//     on<SetPercentageEvent>((event, emit) {
//       final newPercentage = event.percentage;
//       final price = state.price;

//       int discount = state.discount;

//       if (newPercentage != 0) {
//         final discountValue = price - (price * newPercentage / 100);
//         discount = double.parse(discountValue.toStringAsFixed(2)).toInt();
//       }else{
//         discount = 0;
//       }

//       emit(state.copyWith(percentage: newPercentage, discount: discount));
//     });

//     on<SubmitSmsBundleEvent>((event, emit) async {
//       if (state.owner.isEmpty || state.quantity <= 0 || state.price <= 0) {
//         emit(state.copyWith(
//           addResposne:
//               ApiResponse.error("Please fill all required fields properly."),
//         ));
//         return;
//       }

//       emit(state.copyWith(addResposne: ApiResponse.loading()));

//       final params = AddSMSBundleParms(
//         owner: state.owner,
//         quantity: state.quantity,
//         discount: state.discount,
//         price: state.price,
//         percentage: state.percentage,
//       );

//       final result = await addSmsBundleUseCase(params);

//       if (result is DataSuccess<String>) {
//         emit(state.copyWith(addResposne: ApiResponse.completed(result.data)));
//       } else if (result is DataFailure<String>) {
//         emit(state.copyWith(addResposne: ApiResponse.error(result.error)));
//       }
//     });
//   }
// }
