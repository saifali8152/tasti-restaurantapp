import 'package:get_it/get_it.dart';
import 'package:tasti_restaurant_app/core/services/picker_services.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/data/data_sources/queries_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/data/repositories/campaign_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/repositories/campaigns_repo.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/usecases/fetch_campaigns.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/domain/usecases/fetch_campaigns_by_res.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/presentation/bloc/campaign/campaign_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/campaigns/presentation/bloc/campaign_by_res/campaign_by_res_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/data/data_sources/admin_dashboard_remote_api.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/data/repositories/admin_dashboard_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/domain/repositories/admin_dashboard_repo.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/domain/usecases/fetch_admin_dashboard.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/presentation/bloc/admin_dashboard_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/data/data_sources/monthly_fee_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/data/repositories/monthly_fee_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/repositories/fee_repo.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/usecases/fetch_admin_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/usecases/update_fee.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/presentation/bloc/get_monthly_fee_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/data/data_sources/sms_bundle_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/data/repositories/sms_bundle_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/repositories/sms_bundle_repo.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/add_sms_bundle.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/delete_sms_bundle.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/fetch_admin_sms_bundle.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/manage_sms_bundle_discount.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/profile/data/data_sources/profile_remote_api.dart';
import 'package:tasti_restaurant_app/features/admin/profile/data/repositories/profile_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/profile/domain/repositories/profile_repo.dart';
import 'package:tasti_restaurant_app/features/admin/profile/domain/usecases/change_password.dart';
import 'package:tasti_restaurant_app/features/admin/profile/domain/usecases/update_profile_usecase.dart';
import 'package:tasti_restaurant_app/features/admin/profile/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/profile/presentation/bloc/update_profile/profile_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/data/data_sources/admin_reservation_remote_api.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/data/repositories/admin_dashboard_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/domain/repositories/admin_reservation_repo.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/domain/usecases/fetch_admin_reservations.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/presentation/bloc/admin_reservation_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/queries/data/data_sources/queries_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/queries/data/repositories/queries_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/repositories/queries_repo.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/usecases/delete_queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/usecases/fetch_queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/usecases/reply_query.dart';
import 'package:tasti_restaurant_app/features/admin/queries/presentation/bloc/queries_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/requests/data/data_sources/requests_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/requests/data/repositories/requests_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/requests/domain/repositories/requests_repo.dart';
import 'package:tasti_restaurant_app/features/admin/requests/domain/usecases/delete_requests.dart';
import 'package:tasti_restaurant_app/features/admin/requests/domain/usecases/fetch_requests.dart';
import 'package:tasti_restaurant_app/features/admin/requests/presentation/bloc/request_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/data/data_sources/transaction_history_remote_source.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/data/repositories/transaction_history_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/domain/repositories/transaction_history_repo.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/domain/usecases/fetch_admin_transaction_history.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/presentation/bloc/transaction_history_bloc.dart';
import 'package:tasti_restaurant_app/features/auth/domain/usecases/delete_account.dart';
import 'package:tasti_restaurant_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:tasti_restaurant_app/features/auth/presentation/bloc/delete_account/delete_account_bloc.dart';
import 'package:tasti_restaurant_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:tasti_restaurant_app/features/skaleton/cubit/skaleton_cubit.dart';
import 'features/auth/data/data_sources/auth_remote_api.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/repositories/auth_repo.dart';
import 'features/auth/domain/usecases/signout.dart';
import 'features/auth/presentation/bloc/signout/signout_bloc.dart';
import '/core/network/api_services.dart';
import '/core/network/network_service_imp.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/bloc/login/login_bloc.dart';
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
  sl.registerSingleton<IAdminDashboardRemoteApi>(
      AdminDashboardRemoteApiImpl(sl()));
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
  sl.registerSingleton<ICampaignRemoteSourceApi>(CampaignSourceRemoteApiImpl(sl()));

  // Repository
  sl.registerSingleton<IAuthRepo>(AuthRepoImpl(sl()));
  sl.registerSingleton<IAdminDashboardRepo>(AdminDashboardRepoImpl(sl()));
  sl.registerSingleton<IAdminReservationRepo>(AdminReservationRepoImpl(sl()));
  sl.registerSingleton<ISMSBundleRepo>(SMSBundleRepoImpl(sl()));
  sl.registerSingleton<ITransactionHistoryRepo>(
      TransactionHistoryRepoImpl(sl()));
  sl.registerSingleton<IMonthlyFeeRepo>(MonthlyFeeRepoImpl(sl()));
  sl.registerSingleton<IRequestRepo>(RequestRepoImpl(sl()));
  sl.registerSingleton<IQueriesRepo>(QueriesRepoImpl(sl()));
  sl.registerSingleton<IProfileRepo>(ProfileRepoImpl(sl()));
  sl.registerSingleton<ICampaignsRepo>(CampaignRepoImpl(sl()));

  // UseCase
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));
  sl.registerSingleton<FetchAdminDashboardUseCase>(
      FetchAdminDashboardUseCase(sl()));
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
  sl.registerSingleton<FetchRequestUsecase>(
      FetchRequestUsecase(sl()));
  sl.registerSingleton<DeleteRequestUsecase>(
      DeleteRequestUsecase(sl()));
  sl.registerSingleton<FetchQueriesUsecase>(
      FetchQueriesUsecase(sl()));
  sl.registerSingleton<DeleteQueriesUsecase>(
      DeleteQueriesUsecase(sl()));
  sl.registerSingleton<ReplyQueryUsecase>(ReplyQueryUsecase(sl()));
  sl.registerSingleton<DeleteAccountUsecase>(DeleteAccountUsecase(sl()));
  sl.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase(sl()));
  sl.registerSingleton<UpdateProfileUseCase>(UpdateProfileUseCase(sl()));
  sl.registerSingleton<ChangePasswordUsecase>(ChangePasswordUsecase(sl()));
  sl.registerSingleton<FetchCampaignsUsecase>(FetchCampaignsUsecase(sl()));
  sl.registerSingleton<FetchCampaignsByResUsecase>(FetchCampaignsByResUsecase(sl()));

  // Bloc
  sl.registerLazySingleton<CampaignBloc>(() => CampaignBloc(sl()));
  sl.registerLazySingleton<CampaignByResBloc>(() => CampaignByResBloc(sl()));
  sl.registerLazySingleton<SkaletonCubit>(() => SkaletonCubit());
  sl.registerLazySingleton<ChangePasswordBloc>(() => ChangePasswordBloc(sl()));
  sl.registerLazySingleton<ProfileBloc>(() => ProfileBloc(
      pickerServices: sl(),
      updateProfileUseCase: sl(),
      sC: sl(),
      skaletonCubit: sl()));
  sl.registerLazySingleton<LoginBloc>(() => LoginBloc(sl()));
  sl.registerLazySingleton<SignOutBloc>(() => SignOutBloc(sl()));
  sl.registerLazySingleton<DeleteAccountBloc>(() => DeleteAccountBloc(sl()));
  sl.registerLazySingleton<ForgotPasswordBloc>(() => ForgotPasswordBloc(sl()));
  sl.registerLazySingleton<AdminDashboardBloc>(() => AdminDashboardBloc(sl()));
  sl.registerLazySingleton<AdminReservationBloc>(
      () => AdminReservationBloc(sl()));
  sl.registerLazySingleton<FetchAdminSmsBloc>(
      () => FetchAdminSmsBloc(sl(), sl(), sl()));
  sl.registerFactory<FetchTransactionHistoryBloc>(
      () => FetchTransactionHistoryBloc(sl()));
  sl.registerLazySingleton<AdminMonthlyFeeBloc>(
      () => AdminMonthlyFeeBloc(sl(), sl()));
  sl.registerLazySingleton<ManageSmsBundleDiscountBloc>(
      () => ManageSmsBundleDiscountBloc(sl()));
  sl.registerLazySingleton<RequestBloc>(
      () => RequestBloc(sl(), sl()));
  sl.registerLazySingleton<QueriesBloc>(
      () => QueriesBloc(sl(), sl(), sl()));
}
