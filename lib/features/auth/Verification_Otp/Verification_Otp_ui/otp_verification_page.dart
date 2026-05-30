import 'package:course_app/features/auth/Verification_Otp/Verification_Otp_Logic/otp_cubit.dart';
import 'package:course_app/features/auth/Verification_Otp/Verification_Otp_Logic/otp_state.dart';
import 'package:course_app/features/auth/Login/Login_ui/login_page.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/core/Widgets/custom_general_elevated_button.dart';
import 'package:easy_localization/easy_localization.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({super.key, required this.email});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: kMainColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<OtpCubit, OtpState>(
            listener: (context, state) {
              if (state.verifySuccess) {
                context.read<OtpCubit>().resetVerifyStatus();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 4), 
                    content: Text(
                      (state.successMessage ?? 'verified_success').tr(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!.tr())));
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),

                        // الوجة المتحركة الملفتة بديلة الـ Container الثابت
                        const _AnimatedOtpIcon(),
                        
                        const SizedBox(height: 32),

                        Text(
                          'emailVerification'.tr(),
                          textAlign: TextAlign.center,
                          style: AppFonts.style(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: kMainColor,
                          ),
                        ),

                        Text(
                          'otpSentTo'.tr(namedArgs: {'email': widget.email}),
                          textAlign: TextAlign.center,
                          style: AppFonts.style(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: const Color(0xFF949D9E),
                          ),
                        ),
                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) {
                            return SizedBox(
                              width: 45,
                              child: TextFormField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                style: AppFonts.style(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE0E0E0),
                                      width: 2.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: kMainColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (index < 5) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(_focusNodes[index + 1]);
                                    } else {
                                      _focusNodes[index].unfocus();
                                    }
                                  } else {
                                    if (index > 0) {
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(_focusNodes[index - 1]);
                                    }
                                  }
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 40),

                        CustomGeneralElevatedButton(
                          onPressed: (_otpCode.length == 6 && !state.isLoading)
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<OtpCubit>().verifyOtp(_otpCode);
                                  }
                                }
                              : null,
                          text: state.isLoading
                              ? 'verifying'.tr()
                              : 'verifyNow'.tr(),
                          textButtonColor: Colors.white,
                          buttonColor: (_otpCode.length == 6 && !state.isLoading)
                              ? kMainColor
                              : Colors.grey,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
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

// الوجة المخصصة للحركة التفاعلية اللطيفة
class _AnimatedOtpIcon extends StatefulWidget {
  const _AnimatedOtpIcon();

  @override
  State<_AnimatedOtpIcon> createState() => _AnimatedOtpIconState();
}

class _AnimatedOtpIconState extends State<_AnimatedOtpIcon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // حركة النبض والاتساع الدائري لخلفية الأيقونة
    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // حركة طفو الأيقونة العلوية صعوداً وهبوطاً بنعومة
    _floatAnimation = Tween<double>(begin: -4.0, end: 4.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // الدائرة الخارجية الكبيرة النباضة المعبرة عن إرسال الإشارات الرقمية
            Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                  color: kMainColor.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // الدائرة المتوسطة لعمق التصميم البصري
            Transform.scale(
              scale: (_pulseAnimation.value * 0.95),
              child: Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  color: kMainColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            // الحاوية الأساسية الحاملة للأيقونة مع تأثير حركة الطفو المريحة للعين
            Transform.translate(
              offset: Offset(0, _floatAnimation.value),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kMainColor.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.mark_email_read_rounded,
                  size: 38,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}