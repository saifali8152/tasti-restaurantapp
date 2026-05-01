import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/presentation/bloc/admin_user_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_bloc.dart';
import '/features/admin/restaurants/presentation/bloc/restaurant_bloc.dart';
import '/features/restaurant-admin/make_reservation/presentation/bloc/make_reservation_bloc.dart';
import '/features/restaurant-admin/reservations/presentation/bloc/reservation_bloc.dart';
import '/features/restaurant-admin/reservations_db/presentation/bloc/customer_reservations/customer_reservations_bloc.dart';
import '/features/restaurant-admin/bundle_billings/presentation/bloc/bundle_billing_bloc.dart';
import '/features/restaurant-admin/food_menu/presentation/bloc/menu_bloc.dart';
import '/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import '/features/restaurant-admin/cuisines/presentation/bloc/cuisine_bloc.dart';
import '/features/restaurant-admin/gallery/presentation/bloc/gallery_bloc.dart';
import '/features/restaurant-admin/set_venue_category/presentation/bloc/venue_bloc.dart';
import '/features/restaurant-admin/working_hours/presentation/bloc/working_hours_bloc.dart';
import '/features/restaurant-admin/reviews/presentation/bloc/reviews_bloc.dart';
import '/features/restaurant-admin/seating_area/presentation/bloc/seating_area_bloc.dart';
import '/features/restaurant-admin/targeted_campaign/presentation/bloc/targeted_campaign_bloc.dart';
import '/config/routes/route_name.dart';
import '/features/admin/campaigns/presentation/bloc/campaign_by_res/campaign_by_res_bloc.dart';
import '/features/admin/events/presentation/bloc/event_bloc.dart';
import 'features/common/profile/presentation/bloc/change_password/change_password_bloc.dart';
import 'features/common/profile/presentation/bloc/update_profile/profile_bloc.dart';
import '/features/admin/queries/presentation/bloc/queries_bloc.dart';
import '/features/admin/requests/presentation/bloc/request_bloc.dart';
import 'features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/dependency_injection.dart';
import '/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import '/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_bloc.dart';
import '/features/admin/reservations_database/presentation/bloc/admin_reservation_bloc.dart';
import '/features/admin/transaction_history/presentation/bloc/transaction_history_bloc.dart';
import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'features/common/skaleton/cubit/skaleton_cubit.dart';
import 'core/services/navigator_services.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SkaletonCubit()),
          BlocProvider(create: (context) => sl<UserCubit>()),
          BlocProvider(create: (context) => sl<ChangePasswordBloc>()),
          BlocProvider(create: (context) => sl<RestaurantBloc>()),
          BlocProvider(create: (context) => sl<ProfileBloc>()),
          BlocProvider(create: (context) => sl<CampaignByResBloc>()),
          BlocProvider(create: (context) => sl<AdminReservationBloc>()),
          BlocProvider(create: (context) => sl<FetchAdminSmsBloc>()),
          BlocProvider(create: (context) => sl<EventBloc>()),
          BlocProvider(create: (context) => sl<FetchTransactionHistoryBloc>()),
          BlocProvider(create: (context) => sl<ManageSmsBundleDiscountBloc>()),
          BlocProvider(create: (context) => sl<RequestBloc>()),
          BlocProvider(create: (context) => sl<QueriesBloc>()),
          BlocProvider(create: (context) => sl<VenueBloc>()),
          BlocProvider(create: (context) => sl<CuisineBloc>()),
          BlocProvider(create: (context) => sl<GalleryBloc>()),
          BlocProvider(create: (context) => sl<WorkingHoursBloc>()),
          BlocProvider(create: (context) => sl<BookingTimeBloc>()),
          BlocProvider(create: (context) => sl<MenuBloc>()),
          BlocProvider(create: (context) => sl<ReviewsBloc>()),
          BlocProvider(create: (context) => sl<SeatingAreaBloc>()),
          BlocProvider(create: (context) => sl<RestaurantUserBloc>()),
          BlocProvider(create: (context) => sl<AdminUserBloc>()),
          BlocProvider(create: (context) => sl<BundleBillingBloc>()),
          BlocProvider(create: (context) => sl<ReservationBloc>()),
          BlocProvider(create: (context) => sl<MakeReservationBloc>()),
          BlocProvider(create: (context) => sl<TargetedCampaignBloc>()),
          BlocProvider(create: (context) => sl<CustomerReservationsBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigatorService.navigatorKey,
          title: 'Tasti Restaurant',
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}
