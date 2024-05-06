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
import 'package:nur_pay/screens/auth/register/widgets/password_text_field.dart';
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

  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstPasswordController =
      TextEditingController();
  final TextEditingController _secondPasswordController =
      TextEditingController();

  String firstPassword = '';
  String secondPassword = '';

  @override
  void dispose() {
    _lastnameController.dispose();
    _phoneController.dispose();
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
                      50.getH(),
                      Text(
                        textAlign: TextAlign.start,
                        "Create\nan account",
                        style: AppTextStyle.interBold.copyWith(
                          fontSize: 35.w,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      20.getH(),
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
                            20.getH(),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _lastnameController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG LASTNAME!!!";
                                } else if (!AppConstants.emailRegExp
                                    .hasMatch(value)) {
                                  return "WRONG LASTNAME FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Lastname",
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
                            20.getH(),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _phoneController,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PHONE NUMBER!!!";
                                } else if (!AppConstants.phoneRegExp
                                    .hasMatch(value)) {
                                  return "WRONG PHONE NUMBER FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Phone number",
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
                            20.getH(),
                            PasswordTextField(
                              isVisible: isVisible,
                              valueChanged: (v) {
                                firstPassword = v;
                              },
                              textEditingController: _firstPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PHONE NUMBER!!!";
                                } else if (!AppConstants.phoneRegExp
                                    .hasMatch(value)) {
                                  return "WRONG PHONE NUMBER FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              voidCallback: () {
                                isVisible = !isVisible;
                                setState(() {});
                              }, title: 'Password',
                            ),
                            20.getH(),
                            PasswordTextField(
                              isVisible: isSecondVisible,
                              valueChanged: (v) {
                                secondPassword = v;
                              },
                              textEditingController: _secondPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PASSWORD!!!";
                                } else if (firstPassword != secondPassword) {
                                  return "BOTH PASSWORDS MUST MATCH!!!";
                                } else {
                                  return null;
                                }
                              },
                              voidCallback: () {
                                isSecondVisible = !isSecondVisible;
                                setState(() {});
                              }, title: 'Confirm password',
                            ),
                          ],
                        ),
                      ),
                      20.getH(),
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            50,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              UserModel userModel = UserModel(
                                username: _userNameController.text,
                                lastname: _lastnameController.text,
                                password: _secondPasswordController.text,
                                userId: '',
                                imageUrl: '',
                                phoneNumber: _phoneController.text,
                                email: _userNameController.text,
                                fcmToken: '',
                                authUUId: '',
                              );
                              context.read<AuthBloc>().add(
                                    RegisterUserEvent(
                                      userModel: userModel,
                                    ),
                                  );
                              if (state.formStatus == FormStatus.error) {
                                showSnackBar(
                                  context: context,
                                  message: state.errorMessage,
                                  color: Colors.red,
                                );
                              } else {
                                showSnackBar(
                                  context: context,
                                  message: "REGISTERED SUCCESSFULLY",
                                );
                              }
                            } else {
                              showSnackBar(
                                context: context,
                                color: Colors.red,
                                message:
                                    "PLEASE ENTER ALL LINES CORRECTLY AND COMPLETELY!!!",
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
                      20.getH(),
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
                      10.getH(),
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
                      10.getH(),
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
            } else if (state.formStatus == FormStatus.authenticated) {
              if (state.statusMessage == "registered") {
                if (state.formStatus == FormStatus.error) {
                  showSnackBar(
                    context: context,
                    message: state.errorMessage,
                    color: Colors.red,
                  );
                } else if (state.formStatus == FormStatus.authenticated) {
                  BlocProvider.of<UserProfileBloc>(context).add(
                    AddUserEvent(
                      userModel: state.userModel,
                    ),
                  );
                }
              }
              await Future.delayed(
                const Duration(
                  seconds: 1,
                ),
              );
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.setPinRoute,
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
