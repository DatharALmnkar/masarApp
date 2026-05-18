import 'package:course_app/Cash/cash_Helper.dart';
import 'package:course_app/features/Login/Login_Logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        isButtonActive: _isFormValid(email: value),
        clearError: true,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        isButtonActive: _isFormValid(password: value),
        clearError: true,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordHidden: !state.isPasswordHidden));
  }

  bool _isFormValid({String? email, String? password}) {
    final mail = email ?? state.email;
    final pass = password ?? state.password;

    return mail.trim().isNotEmpty && pass.trim().isNotEmpty;
  }

  Future<void> login() async {
    if (!state.isButtonActive || state.isLoading) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      await Future.delayed(const Duration(seconds: 2));

      await CashHelper.saveData(key: 'token', value: 'demo_token');

      emit(
        state.copyWith(
          isLoading: false,
          loginSuccess: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
