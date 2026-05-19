import 'package:course_app/features/auth/Login/Login_data/login_repos.dart';
import 'package:course_app/features/auth/Login/Login_Logic/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _repo;

  LoginCubit(this._repo) : super(const LoginState());

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
      await _repo.login(email: state.email, password: state.password);

      emit(state.copyWith(isLoading: false, loginSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
