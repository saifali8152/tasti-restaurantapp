import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
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
