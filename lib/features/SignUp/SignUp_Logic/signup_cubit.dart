import 'package:course_app/features/SignUp/SignUp_Data/signup_repos.dart';
import 'package:course_app/features/SignUp/SignUp_Logic/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _repo;

  SignupCubit({SignupRepo? repo})
      : _repo = repo ?? SignupRepo(),
        super(const SignupState());

  void firstNameChanged(String value) {
    emit(
      state.copyWith(
        firstName: value,
        isButtonActive: _isFormValid(firstName: value),
        clearError: true,
      ),
    );
  }

  void lastNameChanged(String value) {
    emit(
      state.copyWith(
        lastName: value,
        isButtonActive: _isFormValid(lastName: value),
        clearError: true,
      ),
    );
  }

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

  bool _isFormValid({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    final first = firstName ?? state.firstName;
    final last = lastName ?? state.lastName;
    final mail = email ?? state.email;
    final pass = password ?? state.password;

    return first.trim().isNotEmpty &&
        last.trim().isNotEmpty &&
        mail.trim().isNotEmpty &&
        pass.trim().isNotEmpty;
  }

  Future<void> signup() async {
    if (!state.isButtonActive || state.isLoading) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final response = await _repo.register(
        email: state.email,
        password: state.password,
        firstName: state.firstName,
        lastName: state.lastName,
      );

      emit(
        state.copyWith(
          isLoading: false,
          signupSuccess: true,
          successMessage: response.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
