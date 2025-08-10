import 'package:get_it/get_it.dart';
import 'package:tasti_restaurant_app/features/common/manage_fee/domain/usecases/initialize_payment_fee.dart';
import 'package:tasti_restaurant_app/features/common/manage_fee/domain/usecases/verify_payment.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/data/data_sources/restaurant_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/data/repositories/restaurant_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/repositories/restaurant_repo.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/usecases/active_restaurant.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/usecases/fetch_restaurant.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/domain/usecases/suspend_restaurant.dart';
import 'package:tasti_restaurant_app/features/admin/restaurants/presentation/bloc/restaurant_bloc.dart';
import 'package:tasti_restaurant_app/features/common/auth/domain/usecases/signup.dart';
import 'package:tasti_restaurant_app/features/common/auth/presentation/bloc/signup/signup_bloc.dart';
import 'package:tasti_restaurant_app/features/common/location/data/data_sources/location_repo.dart';
import 'package:tasti_restaurant_app/features/common/location/data/repositories/location_repo.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/repositories/location_repo.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/usecases/get_location_usecase.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/usecases/get_predictions_usecase.dart';
import 'package:tasti_restaurant_app/features/common/location/presentation/bloc/location_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/data/data_sources/menu_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/data/repositories/menu_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/domain/repositories/menu_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/domain/usecases/add_menu.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/domain/usecases/fetch_menu.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/food_menu/presentation/bloc/menu_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/data/data_sources/booking_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/data/repositories/booking_time_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/repositories/booking_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/activate_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/deactivate_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/fetch_times_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/update_time_duration.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/presentation/bloc/booking_time_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/data_sources/create_restaurant_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/repositories/create_restaurant_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/repositories/create_restaurant_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/create_new_restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/update_restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/presentation/bloc/create_new_restaurant_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/data/data_sources/cuisine_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/data/repositories/cuisine_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/repositories/cuisines.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/usecases/add_cuisine.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/usecases/delete_cuisine.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/usecases/fetch_cuisine.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/presentation/bloc/cuisine_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/data/data_sources/dashboard_remote_api.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/data/repositories/dashboard_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/domain/repositories/dashboard_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/domain/usecases/fetch_dashboard.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/data/data_sources/gallery_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/data/repositories/gallery_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/repositories/gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/usecases/add_gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/usecases/delete_gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/domain/usecases/fetch_gallery.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/gallery/presentation/bloc/gallery_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/data/data_sources/venue_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/data/repositories/venue_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/repositories/venue_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/usecases/add_venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/usecases/delete_venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/usecases/fetch_venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/presentation/bloc/venue_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/data/data_sources/working_hour_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/data/repositories/working_hour_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/repositories/working_hour.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/usecases/add_working_hour.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/usecases/fetch_working_hour.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/domain/usecases/update_working_hour.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/working_hours/presentation/bloc/working_hours_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/data/data_sources/review_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/data/repositories/review_repo_impl.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/repositories/review_repo.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/usecases/fetch_reviews.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/usecases/unverify_review.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/usecases/verify_review.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/presentation/bloc/reviews_bloc.dart';
import '/core/services/picker_services.dart';
import '/features/admin/campaigns/data/data_sources/campaign_remote_source.dart';
import '/features/admin/campaigns/data/repositories/campaign_repo_impl.dart';
import '/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import '/features/admin/campaigns/domain/usecases/approve_event.dart';
import '/features/admin/campaigns/domain/usecases/fetch_campaigns.dart';
import '/features/admin/campaigns/domain/usecases/fetch_campaigns_by_res.dart';
import '/features/admin/campaigns/presentation/bloc/campaign/campaign_bloc.dart';
import '/features/admin/campaigns/presentation/bloc/campaign_by_res/campaign_by_res_bloc.dart';
import '/features/admin/dashboard/data/data_sources/admin_dashboard_remote_api.dart';
import '/features/admin/dashboard/data/repositories/admin_dashboard_repo_impl.dart';
import '/features/admin/dashboard/domain/repositories/admin_dashboard_repo.dart';
import '/features/admin/dashboard/domain/usecases/fetch_admin_dashboard.dart';
import '/features/admin/dashboard/presentation/bloc/admin_dashboard_bloc.dart';
import '/features/admin/events/data/data_sources/event_remote_source.dart';
import '/features/admin/events/data/repositories/queries_repo_impl.dart';
import '/features/admin/events/domain/repositories/event_repo.dart';
import '/features/admin/events/domain/usecases/add_event.dart';
import '/features/admin/events/domain/usecases/delete_event.dart';
import '/features/admin/events/domain/usecases/fetch_events.dart';
import '/features/admin/events/domain/usecases/update_event.dart';
import '/features/admin/events/presentation/bloc/event_bloc.dart';
import 'features/common/manage_fee/data/data_sources/monthly_fee_remote_source.dart';
import 'features/common/manage_fee/data/repositories/monthly_fee_repo_impl.dart';
import 'features/common/manage_fee/domain/repositories/fee_repo.dart';
import 'features/common/manage_fee/domain/usecases/fetch_admin_fee.dart';
import 'features/common/manage_fee/domain/usecases/update_fee.dart';
import 'features/common/manage_fee/presentation/bloc/get_monthly_fee_bloc.dart';
import '/features/admin/manage_sms/data/data_sources/sms_bundle_remote_source.dart';
import '/features/admin/manage_sms/data/repositories/sms_bundle_repo_impl.dart';
import '/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import '/features/admin/manage_sms/domain/usecases/add_sms_bundle.dart';
import '/features/admin/manage_sms/domain/usecases/delete_sms_bundle.dart';
import '/features/admin/manage_sms/domain/usecases/fetch_admin_sms_bundle.dart';
import '/features/admin/manage_sms/domain/usecases/manage_sms_bundle_discount.dart';
import '/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import '/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_bloc.dart';
import 'features/common/profile/data/data_sources/profile_remote_api.dart';
import 'features/common/profile/data/repositories/profile_repo_impl.dart';
import 'features/common/profile/domain/repositories/profile_repo.dart';
import 'features/common/profile/domain/usecases/change_password.dart';
import 'features/common/profile/domain/usecases/update_profile_usecase.dart';
import 'features/common/profile/presentation/bloc/change_password/change_password_bloc.dart';
import 'features/common/profile/presentation/bloc/update_profile/profile_bloc.dart';
import '/features/admin/reservations_database/data/data_sources/admin_reservation_remote_api.dart';
import '/features/admin/reservations_database/data/repositories/admin_dashboard_repo_impl.dart';
import '/features/admin/reservations_database/domain/repositories/admin_reservation_repo.dart';
import '/features/admin/reservations_database/domain/usecases/fetch_admin_reservations.dart';
import '/features/admin/reservations_database/presentation/bloc/admin_reservation_bloc.dart';
import '/features/admin/queries/data/data_sources/queries_remote_source.dart';
import '/features/admin/queries/data/repositories/queries_repo_impl.dart';
import '/features/admin/queries/domain/repositories/queries_repo.dart';
import '/features/admin/queries/domain/usecases/delete_queries.dart';
import '/features/admin/queries/domain/usecases/fetch_queries.dart';
import '/features/admin/queries/domain/usecases/reply_query.dart';
import '/features/admin/queries/presentation/bloc/queries_bloc.dart';
import '/features/admin/requests/data/data_sources/requests_remote_source.dart';
import '/features/admin/requests/data/repositories/requests_repo_impl.dart';
import '/features/admin/requests/domain/repositories/requests_repo.dart';
import '/features/admin/requests/domain/usecases/delete_requests.dart';
import '/features/admin/requests/domain/usecases/fetch_requests.dart';
import '/features/admin/requests/presentation/bloc/request_bloc.dart';
import '/features/admin/transaction_history/data/data_sources/transaction_history_remote_source.dart';
import '/features/admin/transaction_history/data/repositories/transaction_history_repo_impl.dart';
import '/features/admin/transaction_history/domain/repositories/transaction_history_repo.dart';
import '/features/admin/transaction_history/domain/usecases/fetch_admin_transaction_history.dart';
import '/features/admin/transaction_history/presentation/bloc/transaction_history_bloc.dart';
import 'features/common/auth/domain/usecases/delete_account.dart';
import 'features/common/auth/domain/usecases/forgot_password.dart';
import 'features/common/auth/presentation/bloc/delete_account/delete_account_bloc.dart';
import 'features/common/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'features/common/skaleton/cubit/skaleton_cubit.dart';
import 'features/common/skaleton/user_cubit/skaleton_cubit.dart';
import 'features/common/auth/data/data_sources/auth_remote_api.dart';
import 'features/common/auth/data/repositories/auth_repo_impl.dart';
import 'features/common/auth/domain/repositories/auth_repo.dart';
import 'features/common/auth/domain/usecases/signout.dart';
import 'features/common/auth/presentation/bloc/signout/signout_bloc.dart';
import '/core/network/api_services.dart';
import '/core/network/network_service_imp.dart';
import 'features/common/auth/domain/usecases/login.dart';
import 'features/common/auth/presentation/bloc/login/login_bloc.dart';
import '/core/services/session_controller.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<SessionController>(SessionController());
  sl.registerSingleton<PickerServices>(PickerServices());

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // General Api Services
  sl.registerSingleton<IApiService>(NetworkApiServiceImpl(sl()));

  // Api Services
  sl.registerSingleton<IAuthRemoteApi>(AuthRemoteApiImpl(sl()));
  sl.registerSingleton<IAdminDashboardRemoteApi>(AdminDashboardRemoteApiImpl(sl()));
  sl.registerSingleton<IDashboardRemoteApi>(DashboardRemoteApiImpl(sl()));
  sl.registerSingleton<IAdminReservationRemoteApi>(
      AdminReservationRemoteApiImpl(sl()));
  sl.registerSingleton<ISMSBundleRemoteSourceApi>(
      SMSBundleSourceRemoteApiImpl(sl()));
  sl.registerSingleton<IMonthlyFeeRemoteSourceApi>(
      MonthlyFeeSourceRemoteApiImpl(sl()));
  sl.registerSingleton<ITransactionHistoryRemoteSourceApi>(
      TransactionHistoryRemoteSourceImp(sl()));
  sl.registerSingleton<IRequestRemoteSourceApi>(
      RequestSourceRemoteApiImpl(sl()));
  sl.registerSingleton<IQueriesRemoteSourceApi>(
      QueriesSourceRemoteApiImpl(sl()));
  sl.registerSingleton<IProfileRemoteApi>(ProfileRemoteApiImpl(sl()));
  sl.registerSingleton<ICampaignRemoteSourceApi>(
      CampaignSourceRemoteApiImpl(sl()));
  sl.registerSingleton<IEventRemoteSourceApi>(EventSourceRemoteApiImpl(sl()));
  sl.registerSingleton<IRestaurantRemoteSourceApi>(
      RestaurantSourceRemoteApiImpl(sl()));
  sl.registerSingleton<ICreateRestaurantRemoteApi>(
      CreateRestaurantRemoteApiImpl(sl()));
  sl.registerSingleton<ILocationRemoteApi>(LocationRemoteApiImpl(sl()));
  sl.registerSingleton<IVenueRemoteApi>(VenueRemoteApiImpl(sl()));
  sl.registerSingleton<ICuisineRemoteApi>(CuisineRemoteApiImpl(sl()));
  sl.registerSingleton<IGalleryRemoteApi>(GalleryRemoteApiImpl(sl()));
  sl.registerSingleton<IWorkingHourRemoteApi>(WorkingHourRemoteApiImpl(sl()));
  sl.registerSingleton<IBookingTimeRemoteApi>(BookingTimeRemoteApiImpl(sl()));
  sl.registerSingleton<IMenuRemoteApi>(MenuRemoteApiImpl(sl()));
  sl.registerSingleton<IReviewsRemoteApi>(ReviewsRemoteApiImpl(sl()));

  // Repository
  sl.registerSingleton<IReviewsRepo>(ReviewsRepoImpl(sl()));
  sl.registerSingleton<IMenuRepo>(MenuRepoImpl(sl()));
  sl.registerSingleton<IBookingTimeRepo>(BookingTimeRepoImpl(sl()));
  sl.registerSingleton<IWorkingHourRepo>(WorkingHourRepoImpl(sl()));
  sl.registerSingleton<IAuthRepo>(AuthRepoImpl(sl()));
  sl.registerSingleton<IGalleryRepo>(GalleryRepoImpl(sl()));
  sl.registerSingleton<ICuisinesRepo>(CuisineRepoImpl(sl()));
  sl.registerSingleton<IVenueRepo>(VenueRepoImpl(sl()));
  sl.registerSingleton<ILocationRepo>(LocationRepoImpl(sl()));
  sl.registerSingleton<IAdminDashboardRepo>(AdminDashboardRepoImpl(sl()));
  sl.registerSingleton<IDashboardRepo>(DashboardRepoImpl(sl()));
  sl.registerSingleton<IAdminReservationRepo>(AdminReservationRepoImpl(sl()));
  sl.registerSingleton<ISMSBundleRepo>(SMSBundleRepoImpl(sl()));
  sl.registerSingleton<ITransactionHistoryRepo>(
      TransactionHistoryRepoImpl(sl()));
  sl.registerSingleton<IMonthlyFeeRepo>(MonthlyFeeRepoImpl(sl()));
  sl.registerSingleton<IRequestRepo>(RequestRepoImpl(sl()));
  sl.registerSingleton<IQueriesRepo>(QueriesRepoImpl(sl()));
  sl.registerSingleton<IProfileRepo>(ProfileRepoImpl(sl()));
  sl.registerSingleton<ICampaignsRepo>(CampaignRepoImpl(sl()));
  sl.registerSingleton<IEventRepo>(EventRepoImpl(sl()));
  sl.registerSingleton<IRestaurantRepo>(RestaurantRepoImpl(sl()));
  sl.registerSingleton<ICreateRestaurantRepo>(CreateRestaurantRepoImpl(sl()));

  // UseCase
  sl.registerSingleton<FetchVenueUsecase>(FetchVenueUsecase(sl()));
  sl.registerSingleton<DeleteVenueUsecase>(DeleteVenueUsecase(sl()));
  sl.registerSingleton<AddVenueUsecase>(AddVenueUsecase(sl()));
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));
  sl.registerSingleton<FetchAdminDashboardUseCase>(FetchAdminDashboardUseCase(sl()));
  sl.registerSingleton<FetchDashboardUseCase>(FetchDashboardUseCase(sl()));
  sl.registerSingleton<FetchAdminReservationsUseCase>(
      FetchAdminReservationsUseCase(sl()));
  sl.registerSingleton<AddSMSBundleUsecase>(AddSMSBundleUsecase(sl()));
  sl.registerSingleton<FetchAdminSmsBundleUsecase>(
      FetchAdminSmsBundleUsecase(sl()));
  sl.registerSingleton<DeleteSMSBundleUsecase>(DeleteSMSBundleUsecase(sl()));
  sl.registerSingleton<FetchAdminTransactionHistory>(
      FetchAdminTransactionHistory(sl()));
  sl.registerSingleton<ManageSmsBundleDiscountUsecase>(
      ManageSmsBundleDiscountUsecase(sl()));
  sl.registerSingleton<FetchAdminMonthlyFeeUsecase>(
      FetchAdminMonthlyFeeUsecase(sl()));
  sl.registerSingleton<UpdateAdminMonthlyFeeUsecdase>(
      UpdateAdminMonthlyFeeUsecdase(sl()));
  sl.registerSingleton<FetchRequestUsecase>(FetchRequestUsecase(sl()));
  sl.registerSingleton<DeleteRequestUsecase>(DeleteRequestUsecase(sl()));
  sl.registerSingleton<FetchQueriesUsecase>(FetchQueriesUsecase(sl()));
  sl.registerSingleton<DeleteQueriesUsecase>(DeleteQueriesUsecase(sl()));
  sl.registerSingleton<ReplyQueryUsecase>(ReplyQueryUsecase(sl()));
  sl.registerSingleton<DeleteAccountUsecase>(DeleteAccountUsecase(sl()));
  sl.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase(sl()));
  sl.registerSingleton<UpdateProfileUseCase>(UpdateProfileUseCase(sl()));
  sl.registerSingleton<ChangePasswordUsecase>(ChangePasswordUsecase(sl()));
  sl.registerSingleton<FetchCampaignsUsecase>(FetchCampaignsUsecase(sl()));
  sl.registerSingleton<FetchCampaignsByResUsecase>(
      FetchCampaignsByResUsecase(sl()));
  sl.registerSingleton<FetchEventsUsecase>(FetchEventsUsecase(sl()));
  sl.registerSingleton<DeleteEventUsecase>(DeleteEventUsecase(sl()));
  sl.registerSingleton<ApproveCampaignUsecase>(ApproveCampaignUsecase(sl()));
  sl.registerSingleton<AddEventUsecase>(AddEventUsecase(sl()));
  sl.registerSingleton<UpdateEventUsecase>(UpdateEventUsecase(sl()));
  sl.registerSingleton<FetchRestaurantUsecase>(FetchRestaurantUsecase(sl()));
  sl.registerSingleton<ActiveRestaurantUsecase>(ActiveRestaurantUsecase(sl()));
  sl.registerSingleton<SuspendRestaurantUsecase>(
      SuspendRestaurantUsecase(sl()));
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
  sl.registerSingleton<CreateNewRestaurantUsecase>(
      CreateNewRestaurantUsecase(sl()));
  sl.registerSingleton<GetPlaceDetailsUseCase>(GetPlaceDetailsUseCase(sl()));
  sl.registerSingleton<GetPlacePredictionsUseCase>(GetPlacePredictionsUseCase(sl()));
  sl.registerSingleton<InitializePaymentFeeUsecase>(InitializePaymentFeeUsecase(sl()));
  sl.registerSingleton<VerifyPaymentUsecase>(VerifyPaymentUsecase(sl()));
  sl.registerSingleton<UpdateRestaurantUsecase>(UpdateRestaurantUsecase(sl()));
  sl.registerSingleton<DeleteCuisineUsecase>(DeleteCuisineUsecase(sl()));
  sl.registerSingleton<AddCuisineUsecase>(AddCuisineUsecase(sl()));
  sl.registerSingleton<FetchCuisineUsecase>(FetchCuisineUsecase(sl()));
  sl.registerSingleton<FetchGalleryUsecase>(FetchGalleryUsecase(sl()));
  sl.registerSingleton<DeleteGalleryUsecase>(DeleteGalleryUsecase(sl()));
  sl.registerSingleton<AddGalleryUsecase>(AddGalleryUsecase(sl()));
  sl.registerSingleton<AddWorkingHourUsecase>(AddWorkingHourUsecase(sl()));
  sl.registerSingleton<UpdateWorkingHourUsecase>(UpdateWorkingHourUsecase(sl()));
  sl.registerSingleton<FetchWorkingHourUsecase>(FetchWorkingHourUsecase(sl()));
  sl.registerSingleton<FetchTimesDataUsecase>(FetchTimesDataUsecase(sl()));
  sl.registerSingleton<ActivateTimeUsecase>(ActivateTimeUsecase(sl()));
  sl.registerSingleton<DeactivateTimeUsecase>(DeactivateTimeUsecase(sl()));
  sl.registerSingleton<UpdateTimeDurationUsecase>(UpdateTimeDurationUsecase(sl()));
  sl.registerSingleton<AddMenuUsecase>(AddMenuUsecase(sl()));
  sl.registerSingleton<FetchMenuUsecase>(FetchMenuUsecase(sl()));
  sl.registerSingleton<FetchReviewsUsecase>(FetchReviewsUsecase(sl()));
  sl.registerSingleton<VerifyReviewUsecase>(VerifyReviewUsecase(sl()));
  sl.registerSingleton<UnVerifyReviewUsecase>(UnVerifyReviewUsecase(sl()));

  // Bloc
  sl.registerLazySingleton<ReviewsBloc>(() => ReviewsBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<MenuBloc>(() => MenuBloc(sl(), sl()));
  sl.registerLazySingleton<BookingTimeBloc>(() => BookingTimeBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<WorkingHoursBloc>(() => WorkingHoursBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<GalleryBloc>(() => GalleryBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<CuisineBloc>(() => CuisineBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<VenueBloc>(() => VenueBloc(sl(), sl(), sl()));
  sl.registerLazySingleton<CreateNewRestaurantBloc>(() => CreateNewRestaurantBloc(sl(), sl()));
  sl.registerLazySingleton<CampaignBloc>(() => CampaignBloc(sl()));
  sl.registerLazySingleton<CampaignByResBloc>(
      () => CampaignByResBloc(sl(), sl()));
  sl.registerLazySingleton<SkaletonCubit>(() => SkaletonCubit());
  sl.registerLazySingleton<UserCubit>(() => UserCubit());
  sl.registerLazySingleton<ChangePasswordBloc>(() => ChangePasswordBloc(sl()));
  sl.registerLazySingleton<EventBloc>(() => EventBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc(
      pickerServices: sl(),
      updateProfileUseCase: sl(),
      sC: sl(),
      userCubit: sl()));
  sl.registerLazySingleton<LoginBloc>(() => LoginBloc(sl()));
  sl.registerLazySingleton<SignOutBloc>(() => SignOutBloc(sl()));
  sl.registerLazySingleton<DeleteAccountBloc>(() => DeleteAccountBloc(sl()));
  sl.registerLazySingleton<ForgotPasswordBloc>(() => ForgotPasswordBloc(sl()));
  sl.registerLazySingleton<AdminDashboardBloc>(() => AdminDashboardBloc(sl()));
  sl.registerLazySingleton<DashboardBloc>(() => DashboardBloc(sl()));
  sl.registerLazySingleton<AdminReservationBloc>(
      () => AdminReservationBloc(sl()));
  sl.registerLazySingleton<SignupBloc>(() => SignupBloc(sl()));
  sl.registerLazySingleton<FetchAdminSmsBloc>(
      () => FetchAdminSmsBloc(sl(), sl(), sl()));
  sl.registerFactory<FetchTransactionHistoryBloc>(() => FetchTransactionHistoryBloc(sl()));
  sl.registerLazySingleton<LocationBloc>(() => LocationBloc(sl(), sl()));
  sl.registerLazySingleton<AdminMonthlyFeeBloc>(() => AdminMonthlyFeeBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<ManageSmsBundleDiscountBloc>(
      () => ManageSmsBundleDiscountBloc(sl()));
  sl.registerLazySingleton<RestaurantBloc>(
      () => RestaurantBloc(sl(), sl(), sl()));
  sl.registerFactory<RequestBloc>(() => RequestBloc(sl(), sl()));
  sl.registerFactory<QueriesBloc>(() => QueriesBloc(sl(), sl(), sl()));
}
