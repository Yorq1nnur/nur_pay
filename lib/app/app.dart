import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/services/local_notification_service.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.splashScreen,
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
