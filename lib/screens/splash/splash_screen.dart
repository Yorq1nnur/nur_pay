import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/data/local/storage_repository.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nur_pay/utils/images/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    if (!mounted) return;

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      bool isNewUser = StorageRepository.getBool(
        key: "is_new_user",
      );
      if (isNewUser) {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.loginRoute,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.onBoardingRoute,
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        RouteNames.tabRoute,
      );
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(
      context,
    ).size.width;
    height = MediaQuery.of(
      context,
    ).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: AppColors.authContainerGradient,
        ),
        child: Center(
          child: Lottie.asset(
            AppImages.splash,
          ),
        ),
      ),
    );
  }
}
