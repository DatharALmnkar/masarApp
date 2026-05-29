import 'package:course_app/core/Widgets/custom_general_elevated_button.dart';
import 'package:course_app/core/Widgets/custom_text_button.dart';
import 'package:course_app/core/Widgets/custom_text_form_field.dart';
import 'package:course_app/core/constants/app_assets.dart';
import 'package:course_app/core/helper_functions/form_validators.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/features/auth/Login/Login_ui/login_page.dart';
import 'package:course_app/features/auth/SignUp/SignUp_Logic/signup_cubit.dart';
import 'package:course_app/features/auth/SignUp/SignUp_Logic/signup_state.dart';
import 'package:course_app/features/auth/SignUp/SignUp_ui/otp_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.signupSuccess) {
                  context.read<SignupCubit>().resetSignupStatus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.successMessage ??
                            'Sign up successful! Please verify your email.',
                      ),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<SignupCubit>(),
                        child: OtpVerificationPage(
                          email: context.read<SignupCubit>().state.email,
                        ),
                      ),
                    ),
                  );
                }
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },

              builder: (context, state) {
                return Form(
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
                        'Welcome to Masar',
                        textAlign: TextAlign.center,
                        style: AppFonts.style(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                          color: kMainColor,
                        ),
                      ),

                      Text(
                        'Create your account and start managing your courses with ease',
                        textAlign: TextAlign.center,
                        style: AppFonts.style(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: const Color(0xFF949D9E),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomTextFormField(
                        hintText: 'First Name',
                        textInputType: TextInputType.name,
                        text: 'First Name',
                        validator: FormValidators.required,
                        onChanged: (value) =>
                            context.read<SignupCubit>().firstNameChanged(value),
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        hintText: 'Last Name',
                        textInputType: TextInputType.name,
                        text: 'Last Name',
                        validator: FormValidators.required,
                        onChanged: (value) =>
                            context.read<SignupCubit>().lastNameChanged(value),
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        text: 'Email',
                        validator: FormValidators.email,
                        onChanged: (value) =>
                            context.read<SignupCubit>().emailChanged(value),
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        hintText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        text: 'Password',
                        validator: FormValidators.password,
                        obscureText: state.isPasswordHidden,
                        onChanged: (value) =>
                            context.read<SignupCubit>().passwordChanged(value),
                        suffixIcon: IconButton(
                          onPressed: () => context
                              .read<SignupCubit>()
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
                      CustomGeneralElevatedButton(
                        onPressed: state.isButtonActive && !state.isLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignupCubit>().signup();
                                }
                              }
                            : null,
                        text: state.isLoading ? 'Loading...' : 'Sign Up Now',
                        textButtonColor: Colors.white,
                        buttonColor: state.isButtonActive
                            ? kMainColor
                            : Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      CustomTextButton(
                        text1: 'Already have an account?',
                        text2: 'Login',
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
