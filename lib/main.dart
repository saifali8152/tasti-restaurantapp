import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/route_name.dart';
import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/skaleton/presentation/bloc/cubit/skaleton_cubit.dart';

void main() {
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
      child: MaterialApp(
        title: 'Tasti Restaurant App',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
