import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_event.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/user_model.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/constants/app_constants.dart';
import 'package:nur_pay/utils/images/app_images.dart';
import 'package:nur_pay/utils/sizedbox/get_sizedbox.dart';
import 'package:nur_pay/utils/styles/app_text_style.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = true;
  bool isSecondVisible = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstPasswordController =
      TextEditingController();
  final TextEditingController _secondPasswordController =
      TextEditingController();

  String firstPassword = '';
  String secondPassword = '';

  @override
  void dispose() {
    _emailController.dispose();
    _firstPasswordController.dispose();
    _secondPasswordController.dispose();
    _userNameController.dispose();
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
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            return Container(
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.getH(),
                      Text(
                        "Create\nan account",
                        style: AppTextStyle.interBold.copyWith(
                          fontSize: 40.w,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      30.getH(),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _userNameController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG USERNAME!!!";
                                } else if (!AppConstants.textRegExp
                                    .hasMatch(value)) {
                                  return "WRONG USERNAME FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c676767,
                                ),
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
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _emailController,
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
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c676767,
                                ),
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
                              obscureText: isVisible,
                              onChanged: (v) {
                                firstPassword = v;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _firstPasswordController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PASSWORD!!!";
                                } else if (!AppConstants.passwordRegExp
                                    .hasMatch(value)) {
                                  return "WRONG PASSWORD FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c676767,
                                ),
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
                            24.getH(),
                            TextFormField(
                              obscureText: isSecondVisible,
                              onChanged: (v) {
                                secondPassword = v;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _secondPasswordController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PASSWORD!!!";
                                } else if (firstPassword != secondPassword) {
                                  return "BOTH PASSWORDS MUST MATCH!!!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                labelStyle: AppTextStyle.interBold.copyWith(
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c676767,
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    isSecondVisible
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
                                    isSecondVisible = !isSecondVisible;
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
                      30.getH(),
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              UserModel userModel = UserModel(
                                username: _userNameController.text,
                                lastname: _userNameController.text,
                                password: _secondPasswordController.text,
                                userId: "",
                                imageUrl: '',
                                phoneNumber: _secondPasswordController.text,
                                email: _emailController.text,
                                fcmToken: '',
                                authUUId: '',
                              );
                              context.read<AuthBloc>().add(
                                    RegisterUserEvent(
                                      userModel: userModel,
                                    ),
                                  );
                              BlocProvider.of<UserProfileBloc>(context).add(
                                AddUserEvent(
                                  userModel: userModel,
                                ),
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
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
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
                            child: Center(
                              child: Text(
                                "Create Account",
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
                      30.getH(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 1.h,
                            width: 100.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            child: Text(
                              "Or continue with",
                              style: AppTextStyle.interBold.copyWith(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.c6A707C),
                            ),
                          ),
                          Container(
                            height: 1.h,
                            width: 100.w,
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
                            onTap: () {
                              context.read<AuthBloc>().add(
                                    SignInWithGoogleUserEvent(),
                                  );
                            },
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.google,
                                      height: 30.w,
                                      width: 30.w,
                                    ),
                                    Text(
                                      "Continue with Google",
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
                      20.getH(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "I Already Have an Account",
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
                                  RouteNames.loginRoute,
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: AppTextStyle.interBold.copyWith(
                                    fontSize: 17.w,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.c009FFF,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) async {
            if (state.formStatus == FormStatus.error) {
              showErrorForRegister(
                state.errorMessage,
                context,
              );
            }
            if (state.formStatus == FormStatus.authenticated) {
              if (state.statusMessage == "registered") {
                BlocProvider.of<UserProfileBloc>(context).add(
                  AddUserEvent(
                    userModel: state.userModel,
                  ),
                );
              }
              await Future.delayed(
                const Duration(
                  seconds: 1,
                ),
              );
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.tabRoute,
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
