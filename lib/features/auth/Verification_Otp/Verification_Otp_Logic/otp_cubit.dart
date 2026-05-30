import 'package:course_app/Cash/cache_helper.dart';
import 'package:course_app/core/Apis/Errors/exceptions.dart';
import 'package:course_app/features/auth/Verification_Otp/Verification_Otp_Data/otp_repo.dart';
import 'package:course_app/features/auth/Verification_Otp/Verification_Otp_Logic/otp_state.dart';


import 'package:flutter_bloc/flutter_bloc.dart';



class OtpCubit extends Cubit<OtpState> {

  final OtpRepo _repo;

  OtpCubit({
    OtpRepo? repo,
  }) : _repo = repo ?? OtpRepo(),
       super( OtpState());

  Future<void> verifyOtp(
    String otp,
  ) async {

    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
      ),
    );

    try {

      final token =
          CacheHelper.getString(
        'token',
      ) ?? '';

      if (token.isEmpty) {
        throw 'token_not_found';
      }

      final message =
          await _repo.verifyOtp(
        token: token,
        otpCode: otp,
      );

      emit(
        state.copyWith(
          isLoading: false,
          verifySuccess: true,
          successMessage: message,
        ),
      );

    } catch (e) {

      String errorMessage =
          'something_wrong';

      if (e is ServerException) {

        errorMessage =
            e.errorModel.message;

      } else {

        errorMessage = e.toString();
      }

      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: errorMessage,
        ),
      );
    }
  }

  void resetVerifyStatus() {

    emit(
      state.copyWith(
        verifySuccess: false,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }
}