import 'package:get_it/get_it.dart';
import 'package:tasti_restaurant_app/core/services/picker_services.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/data/data_sources/admin_dashboard_remote_api.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/data/repositories/admin_dashboard_repo_impl.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/domain/repositories/admin_dashboard_repo.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/domain/usecases/fetch_admin_dashboard.dart';
import 'package:tasti_restaurant_app/features/admin/dashboard/presentation/bloc/admin_dashboard_bloc.dart';
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
  sl.registerSingleton<IAdminDashboardRemoteApi>(AdminDashboardRemoteApiImpl(sl()));
  
  // Repository
  sl.registerSingleton<IAuthRepo>(AuthRepoImpl(sl()));
  sl.registerSingleton<IAdminDashboardRepo>(AdminDashboardRepoImpl(sl()));
  
  // UseCase
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));
  sl.registerSingleton<FetchAdminDashboardUseCase>(FetchAdminDashboardUseCase(sl()));
  
  // Bloc
  sl.registerLazySingleton<SkaletonCubit>(() => SkaletonCubit());
  sl.registerLazySingleton<LoginBloc>(() => LoginBloc(sl()));
  sl.registerLazySingleton<SignOutBloc>(() => SignOutBloc(sl()));
  sl.registerLazySingleton<AdminDashboardBloc>(() => AdminDashboardBloc(sl()));
}
