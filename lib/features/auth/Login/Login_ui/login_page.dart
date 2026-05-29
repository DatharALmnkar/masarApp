import 'package:course_app/core/Widgets/custom_general_elevated_button.dart';
import 'package:course_app/core/Widgets/custom_text_button.dart';
import 'package:course_app/core/Widgets/custom_text_form_field.dart';
import 'package:course_app/core/constants/app_assets.dart';
import 'package:course_app/core/helper_functions/form_validators.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/Home/home_page.dart';
import 'package:course_app/features/auth/Login/Login_data/login_repos.dart';
import 'package:course_app/features/auth/Login/Login_Logic/login_cubit.dart';
import 'package:course_app/features/auth/Login/Login_Logic/login_state.dart';
import 'package:course_app/features/auth/Login/Login_ui/forgot_password_page.dart';
import 'package:course_app/features/auth/SignUp/SignUp_ui/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginRepo()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.loginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful!')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppAssets.appLogo,
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: kMainColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              size: 52,
                              color: kMainColor,
                            ),
                          ),
                        ),
                      ),

                      Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: AppFonts.style(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: kMainColor,
                        ),
                      ),

                      Text(
                        'Sign in to continue managing your courses with ease',
                        textAlign: TextAlign.center,
                        style: AppFonts.style(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: const Color(0xFF949D9E),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextFormField(
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        text: 'Email',
                        validator: FormValidators.email,
                        onChanged: (value) =>
                            context.read<LoginCubit>().emailChanged(value),
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        hintText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        text: 'Password',
                        validator: FormValidators.password,
                        obscureText: state.isPasswordHidden,
                        onChanged: (value) =>
                            context.read<LoginCubit>().passwordChanged(value),
                        suffixIcon: IconButton(
                          onPressed: () => context
                              .read<LoginCubit>()
                              .togglePasswordVisibility(),
                          icon: Icon(
                            state.isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xFF949D9E),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot your password?',
                            style: AppFonts.style(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: kMainColor,
                              letterSpacing: 0.002,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomGeneralElevatedButton(
                        onPressed: state.isButtonActive && !state.isLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().login();
                                }
                              }
                            : null,
                        text: state.isLoading ? 'Loading...' : 'Login',
                        textButtonColor: Colors.white,
                        buttonColor: state.isButtonActive
                            ? kMainColor
                            : Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      CustomTextButton(
                        text1: "Doesn't have an account?",
                        text2: 'Sign Up',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
