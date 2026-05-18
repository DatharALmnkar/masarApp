class LoginState {
  final String email;
  final String password;
  final bool isPasswordHidden;
  final bool isButtonActive;
  final bool isLoading;
  final bool loginSuccess;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isPasswordHidden = true,
    this.isButtonActive = false,
    this.isLoading = false,
    this.loginSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isPasswordHidden,
    bool? isButtonActive,
    bool? isLoading,
    bool? loginSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      isLoading: isLoading ?? this.isLoading,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
