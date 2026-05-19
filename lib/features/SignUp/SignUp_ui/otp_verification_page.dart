import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:course_app/core/constants/app_fonts.dart';
import 'package:course_app/core/constants/colors.dart';
import 'package:course_app/core/Widgets/custom_general_elevated_button.dart';
import 'package:course_app/core/Widgets/custom_text_button.dart';

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
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: kMainColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.mark_email_read_rounded,
                      size: 52,
                      color: kMainColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Email Verification',
                    textAlign: TextAlign.center,
                    style: AppFonts.style(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: kMainColor,
                    ),
                  ),

                  Text(
                    'We have sent a 6-digit verification code to:\n${widget.email}',
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
                                _focusNodes[index]
                                    .unfocus(); 
                              }
                            } else {
                           
                              if (index > 0) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[index - 1]);
                              }
                            }
                            setState(
                              () {},
                            ); 
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),

                
                  CustomGeneralElevatedButton(
                    onPressed: _otpCode.length == 6
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              // هنا تستدعي الـ Cubit الخاص بك للتحقق من الكود مثل:
                              // context.read<SignupCubit>().verifyOtp(_otpCode);
                              print("OTP Code Entered: $_otpCode");
                            }
                          }
                        : null, // يبقى الزر معطلاً حتى يكتمل إدخال الـ 6 أرقام
                    text: 'Verify Now',
                    textButtonColor: Colors.white,
                    buttonColor: _otpCode.length == 6
                        ? kMainColor
                        : Colors.grey,
                  ),
                  const SizedBox(height: 15),

                  // زر إعادة إرسال الكود
                  CustomTextButton(
                    text1: "Didn't receive the code?",
                    text2: 'Resend',
                    onPressed: () {
                      // أضف منطق إعادة الإرسال هنا
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
