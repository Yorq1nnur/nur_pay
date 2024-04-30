import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/constants/app_constants.dart';
import 'package:nur_pay/utils/images/app_images.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  final TextEditingController _userNameController =
      TextEditingController(text: "Username or Email");
  final TextEditingController _passwordController =
      TextEditingController(text: "Password");

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.sizeOf(
            context,
          ).height,
          width: MediaQuery.sizeOf(
            context,
          ).width,
          decoration: const BoxDecoration(
            gradient: AppColors.authContainerGradient,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                100.getH(),
                Text(
                  "Welcome\nBack!",
                  style: AppTextStyle.interBold.copyWith(
                    fontSize: 40.w,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                60.getH(),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "WRONG EMAIL!!!";
                          } else if (!AppConstants.emailRegExp
                              .hasMatch(value)) {
                            return "WRONG EMAIL FORMAT!!!";
                          } else {
                            return null;
                          }
                        },
                        style: AppTextStyle.interBold.copyWith(
                          fontSize: 15.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c676767,
                        ),
                        onTap: () {
                          _userNameController.text = '';
                        },
                        controller: _userNameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            size: 30.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.cA8A8A9,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      24.getH(),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "WRONG PASSWORD!!!";
                          } else if (!AppConstants.passwordRegExp
                              .hasMatch(value)) {
                            return "WRONG PASSWORD FORMATT!!!";
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          _passwordController.text = '';
                        },
                        controller: _passwordController,
                        style: AppTextStyle.interBold.copyWith(
                          fontSize: 15.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c676767,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: SvgPicture.asset(
                              isVisible
                                  ? AppImages.eye
                                  : AppImages.eyeUnVisible,
                              width: 25.w,
                              height: 25.h,
                              fit: BoxFit.fill,
                              colorFilter: const ColorFilter.mode(
                                Colors.black,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {
                              isVisible = !isVisible;
                              setState(() {});
                            },
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 30.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.cA8A8A9,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                50.getH(),
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blue,
                            duration: const Duration(
                              seconds: 3,
                            ),
                            content: Text(
                              "SUCCESS",
                              textAlign: TextAlign.center,
                              style: AppTextStyle.interSemiBold,
                            ),
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.tabRoute,
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            duration: const Duration(
                              seconds: 3,
                            ),
                            content: Text(
                              textAlign: TextAlign.center,
                              style: AppTextStyle.interSemiBold,
                              "PLEASE ENTER ALL LINES CORRECTLY AND COMPLETELY!!!",
                            ),
                          ),
                        );
                      }
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 70.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          color: AppColors.c69E4F4,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.25,
                              ),
                              blurRadius: 4,
                              offset: const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),
                        child: Text(
                          "Login",
                          style: AppTextStyle.interBlack.copyWith(
                            fontSize: 20.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                50.getH(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 1.h,
                      width: 115.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      child: Text(
                        "Or login with",
                        style: AppTextStyle.interBold.copyWith(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.c6A707C,
                        ),
                      ),
                    ),
                    Container(
                      height: 1.h,
                      width: 115.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                30.getH(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 30.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          gradient: AppColors.loginWithGoogleGradient,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                AppImages.google,
                                height: 30.w,
                                width: 30.w,
                              ),
                              Text(
                                "Login with Google",
                                style: AppTextStyle.interBold.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                40.getH(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: AppTextStyle.interBold.copyWith(
                          fontSize: 17.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c1E232C,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.registerRoute,
                          );
                        },
                        child: Center(
                          child: Text(
                            "Register Now",
                            style: AppTextStyle.interBold.copyWith(
                              fontSize: 17.w,
                              fontWeight: FontWeight.w700,
                              color: AppColors.c009FFF,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}