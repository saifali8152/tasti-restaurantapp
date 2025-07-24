import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/routes/route_name.dart';
import 'package:tasti_restaurant_app/features/admin/profile/presentation/bloc/change_password/change_password_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/profile/presentation/bloc/update_profile/profile_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/queries/presentation/bloc/queries_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/requests/presentation/bloc/request_bloc.dart';
import '/dependency_injection.dart';
import '/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import '/features/admin/manage_sms/presentation/bloc/manage_sms_bundle_discount/manage_sms_bundle_discount_bloc.dart';
import '/features/admin/reservations_database/presentation/bloc/admin_reservation_bloc.dart';
import '/features/admin/transaction_history/presentation/bloc/transaction_history_bloc.dart';
import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/skaleton/cubit/skaleton_cubit.dart';

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
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(create: (context) => sl<ChangePasswordBloc>()),
          BlocProvider(create: (context) => sl<ProfileBloc>()),
          BlocProvider(create: (context) => sl<AdminReservationBloc>()),
          BlocProvider(create: (context) => sl<FetchAdminSmsBloc>()),
          BlocProvider(create: (context) => sl<FetchTransactionHistoryBloc>()),
          BlocProvider(create: (context) => sl<ManageSmsBundleDiscountBloc>()),
          BlocProvider(create: (context) => sl<RequestBloc>()),
          BlocProvider(create: (context) => sl<QueriesBloc>()),
        ],
        child: MaterialApp(
          title: 'Tasti Restaurant App',
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}
