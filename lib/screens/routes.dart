import 'package:flutter/material.dart';
import 'package:nur_pay/screens/auth/login/login_screen.dart';
import 'package:nur_pay/screens/auth/register/register_screen.dart';
import 'package:nur_pay/screens/no_internet/no_internet_screen.dart';
import 'package:nur_pay/screens/on_boarding/on_boarding_screen.dart';
import 'package:nur_pay/screens/payment/payment_screen.dart';
import 'package:nur_pay/screens/splash/splash_screen.dart';
import 'package:nur_pay/screens/tab/tab_screen.dart';
import 'package:nur_pay/screens/transfer/transfer_screen.dart';

class AppRoutes {
  static Route generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return navigate(
          const SplashScreen(),
        );

      case RouteNames.tabRoute:
        return navigate(
          const TabScreen(),
        );

      case RouteNames.noInternetRoute:
        return navigate(
          NoInternetScreen(
              onInternetComeBack: settings.arguments as VoidCallback),
        );

      case RouteNames.transferRoute:
        return navigate(
          const TransferScreen(),
        );
      case RouteNames.paymentRoute:
        return navigate(
          const PaymentScreen(),
        );
      case RouteNames.loginRoute:
        return navigate(
          const LoginScreen(),
        );
      case RouteNames.onBoardingRoute:
        return navigate(
          const OnBoardingScreen(),
        );
      case RouteNames.registerRoute:
        return navigate(
          const RegisterScreen(),
        );

      default:
        return navigate(
          const Scaffold(
            body: Center(
              child: Text(
                "This kind of rout does not exist!",
              ),
            ),
          ),
        );
    }
  }

  static navigate(
    Widget widget,
  ) {
    return MaterialPageRoute(
      builder: (
        context,
      ) =>
          widget,
    );
  }
}

class RouteNames {
  static const String splashScreen = "/";
  static const String tabRoute = "/tab_route";
  static const String loginRoute = "/login_route";
  static const String registerRoute = "/register_route";
  static const String noInternetRoute = "/no_internet_route";
  static const String paymentRoute = "/payment_route";
  static const String transferRoute = "/transfer_route";
  static const String onBoardingRoute = "/on_boarding_route";
}
