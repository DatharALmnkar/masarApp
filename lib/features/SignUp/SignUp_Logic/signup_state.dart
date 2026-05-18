class SignupState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool isPasswordHidden;
  final bool isButtonActive;
  final bool isLoading;
  final bool signupSuccess;
  final String? errorMessage;

  const SignupState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.isPasswordHidden = true,
    this.isButtonActive = false,
    this.isLoading = false,
    this.signupSuccess = false,
    this.errorMessage,
  });

  SignupState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    bool? isPasswordHidden,
    bool? isButtonActive,
    bool? isLoading,
    bool? signupSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SignupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isButtonActive: isButtonActive ?? this.isButtonActive,
      isLoading: isLoading ?? this.isLoading,
      signupSuccess: signupSuccess ?? this.signupSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
