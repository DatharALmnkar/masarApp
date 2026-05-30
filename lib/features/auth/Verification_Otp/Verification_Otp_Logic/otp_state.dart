class OtpState {
  final bool isLoading;

  final bool verifySuccess;

  final String? successMessage;

  final String? errorMessage;

  const OtpState({
    this.isLoading = false,
    this.verifySuccess = false,
    this.successMessage,
    this.errorMessage,
  });

  OtpState copyWith({
    bool? isLoading,
    bool? verifySuccess,
    String? successMessage,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,

      verifySuccess: verifySuccess ?? this.verifySuccess,

      successMessage: successMessage ?? this.successMessage,

      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
