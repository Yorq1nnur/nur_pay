// import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_utils/my_utils.dart';
// // import 'package:nur_pay/blocs/auth/auth_bloc.dart';
// // import 'package:nur_pay/blocs/auth/auth_state.dart';
// // import 'package:nur_pay/data/models/form_status.dart';
// // import 'package:nur_pay/screens/routes.dart';
// import 'package:nur_pay/utils/colors/app_colors.dart';
// import 'package:lottie/lottie.dart';
// import 'package:nur_pay/utils/images/app_images.dart';
// // import '../../data/local/storage_repo.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   // _init(bool isAuthenticated) async {
//   //   await Future.delayed(
//   //     const Duration(seconds: 3),
//   //   );
//   //   if (!mounted) return;
//   //
//   //   if (isAuthenticated == false) {
//   //     bool isNewUser = StorageRepository.getBool(key: "is_new_user");
//   //     if (isNewUser) {
//   //       Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
//   //     } else {
//   //       Navigator.pushReplacementNamed(context, RouteNames.onBoardingRoute);
//   //     }
//   //   } else {
//   //     Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
//   //   }
//   // }
//
//   _init()async{
//     await Future.delayed(Duration(seconds: 3,);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.sizeOf(context).height;
//     width = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         decoration:
//         const BoxDecoration(gradient: AppColors.authContainerGradient),
//         child: Center(
//           child: Lottie.asset(
//             AppImages.splash,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //
// // BlocListener<AuthBloc, AuthState>(
// // listener: (context, state) {
// // if (state.formStatus == FormStatus.authenticated) {
// // _init(true);
// // } else {
// // _init(false);
// // }
// // },
// // child: Container(
// // height: height,
// // width: width,
// // decoration:
// // const BoxDecoration(gradient: AppColors.authContainerGradient),
// // child: Center(
// // child: Lottie.asset(
// // AppImages.splash,
// // ),
// // ),
// // ),
// // )
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nur_pay/utils/images/app_images.dart';

import '../../data/local/storage_repo.dart';

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
          arguments: '',
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
