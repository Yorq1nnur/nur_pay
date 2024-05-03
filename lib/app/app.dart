import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:nur_pay/data/repositories/user_profile_repo/user_profile_repo.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/services/local_notification_service.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';

import '../data/repositories/auth_repo/auth_repo.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    LocalNotificationService.localNotificationService.init(
      navigatorKey,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => UserProfileRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(
              context.read<UserProfileRepo>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.white,
            ),
            scaffoldBackgroundColor: AppColors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
