import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';
import 'package:nur_pay/blocs/auth/auth_bloc.dart';
import 'package:nur_pay/blocs/auth/auth_event.dart';
import 'package:nur_pay/blocs/auth/auth_state.dart';
import 'package:nur_pay/data/models/form_status.dart';
import 'package:nur_pay/screens/auth/login/widgets/login_button.dart';
import 'package:nur_pay/screens/auth/login/widgets/login_method.dart';
import 'package:nur_pay/screens/auth/login/widgets/login_with_google_button.dart';
import 'package:nur_pay/screens/auth/login/widgets/other_methods_login.dart';
import 'package:nur_pay/screens/auth/register/widgets/password_text_field.dart';
import 'package:nur_pay/screens/auth/register/widgets/simple_text_field.dart';
import 'package:nur_pay/screens/routes.dart';
import 'package:nur_pay/utils/colors/app_colors.dart';
import 'package:nur_pay/utils/constants/app_constants.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        body: BlocConsumer<AuthBloc, AuthState>(
          builder: (
            context,
            state,
          ) {
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
                              title: 'Username',
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                            24.getH(),
                            PasswordTextField(
                              isVisible: isVisible,
                              valueChanged: (v) {},
                              textEditingController: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "WRONG PASSWORD!!!";
                                } else if (!AppConstants.passwordRegExp
                                    .hasMatch(value)) {
                                  return "WRONG PASSWORD FORMAT!!!";
                                } else {
                                  return null;
                                }
                              },
                              voidCallback: () {
                                isVisible = !isVisible;
                                setState(() {});
                              },
                              title: "Password",
                              textInputType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                        ),
                      ),
                      50.getH(),
                      Center(
                        child: LoginButton(
                          voidCallback: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    LoginUserEvent(
                                      username: _userNameController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            } else {
                              showToast(
                                color: Colors.red,
                                context: context,
                                message:
                                    "PLEASE ENTER ALL LINES CORRECTLY AND COMPLETELY!!!",
                              );
                            }
                          },
                        ),
                      ),
                      50.getH(),
                      const LoginMethod(),
                      30.getH(),
                      LoginWithGoogleButton(
                        voidCallback: () async {
                          context.read<AuthBloc>().add(
                                SignInWithGoogleUserEvent(),
                              );
                          methodPrint(
                            "CURRENT AUTH STATE: ${state.formStatus}",
                          );
                        },
                      ),
                      40.getH(),
                      OtherMethodsLogin(
                        voidCallback: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RouteNames.registerRoute,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) async {
            if (state.formStatus == FormStatus.error) {
              methodPrint(
                "THIS IS LOGIN ERROR: ${state.errorMessage}",
              );
              showErrorForLogin(
                state.errorMessage,
                context,
              );
            }
            if (state.formStatus == FormStatus.authenticated) {
              await Future.delayed(
                const Duration(
                  seconds: 2,
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
