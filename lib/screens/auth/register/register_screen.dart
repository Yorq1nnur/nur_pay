import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_bloc.dart';
import 'package:nur_pay/blocs/user_profile/user_profile_event.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/data/models/user_model.dart';
import 'package:nur_pay/screens/auth/register/widgets/google_signing_button.dart';
import 'package:nur_pay/screens/auth/register/widgets/other_method.dart';
import 'package:nur_pay/screens/auth/register/widgets/password_text_field.dart';
import 'package:nur_pay/screens/auth/register/widgets/register_button.dart';
import 'package:nur_pay/screens/auth/register/widgets/register_methods.dart';
import 'package:nur_pay/screens/auth/register/widgets/simple_text_field.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/constants/app_constants.dart';
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
                            SimpleTextField(
                              textEditingController: _userNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG USERNAME!!!";
                                } else if (!AppConstants.textRegExp
                                    .hasMatch(value)) {
                                  return "WRONG USERNAME FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              iconPath: Icons.person,
                              title: "Username",
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                            20.getH(),
                            SimpleTextField(
                              textEditingController: _lastnameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG LASTNAME!!!";
                                } else if (!AppConstants.textRegExp
                                    .hasMatch(value)) {
                                  return "WRONG LASTNAME FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              iconPath: Icons.person,
                              title: "Lastname",
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                            20.getH(),
                            SimpleTextField(
                              textEditingController: _phoneController,
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
                              iconPath: Icons.call,
                              title: "Phone number",
                              textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                            ),
                            20.getH(),
                            PasswordTextField(
                              textInputType: TextInputType.visiblePassword,
                              isVisible: isVisible,
                              valueChanged: (v) {
                                firstPassword = v;
                              },
                              textEditingController: _firstPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PHONE NUMBER!!!";
                                } else if (!AppConstants.passwordRegExp
                                    .hasMatch(value)) {
                                  return "WRONG PHONE NUMBER FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              voidCallback: () {
                                isVisible = !isVisible;
                                setState(() {});
                              },
                              title: 'Password',
                              textInputAction: TextInputAction.next,
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
                              },
                              title: 'Confirm password',
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                      30.getH(),
                      Center(
                        child: RegisterButton(
                          voidCallback: () {
                            if (_formKey.currentState!.validate()) {
                              UserModel userModel = UserModel.initial();
                              userModel = userModel.copyWith(
                                username: _userNameController.text,
                                lastname: _lastnameController.text,
                                password: _secondPasswordController.text,
                                phoneNumber: _phoneController.text,
                                email: _userNameController.text,
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
                        ),
                      ),
                      30.getH(),
                      const RegisterMethods(),
                      20.getH(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Center(
                          child: GoogleSigningButton(
                            voidCallback: () {
                              context.read<AuthBloc>().add(
                                    SignInWithGoogleUserEvent(),
                                  );
                            },
                          ),
                        ),
                      ),
                      20.getH(),
                      OtherMethod(
                        voidCallback: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.loginRoute,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (
            context,
            state,
          ) async {
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
                  UserModel user = state.userModel.copyWith(
                    email: "${state.userModel.email.toLowerCase()}@gmail.com",
                  );
                  BlocProvider.of<UserProfileBloc>(context).add(
                    AddUserEvent(
                      userModel: user,
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
