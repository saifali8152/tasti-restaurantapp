import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/add_sms_bundle_bloc/add_sms_bundle_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/presentation/bloc/get_sms_bundle/get_admin_sms_bloc.dart';
import 'package:tasti_restaurant_app/features/admin/reservations_database/presentation/bloc/admin_reservation_bloc.dart';
import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/skaleton/cubit/skaleton_cubit.dart';

void main() async{
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SkaletonCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => sl<AdminReservationBloc>()),
        BlocProvider(create: (context) => sl<AddSmsBundleBloc>()),
        BlocProvider(create: (context) => sl<FetchAdminSmsBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Tasti Restaurant App',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        routerConfig: router,
      ),
    );
  }
}
