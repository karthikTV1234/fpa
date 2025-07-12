import 'dart:async';
import 'package:child_health_story/core/constants/api_constants.dart';
import 'package:child_health_story/core/constants/strings/error_messages.dart';
import 'package:child_health_story/core/network/api_client.dart';
import 'package:child_health_story/features/auth/model/login_model.dart';
import 'package:child_health_story/features/auth/model/sing_up_model.dart';
import 'package:dio/dio.dart';
import '../../../core/utils/result.dart';

class AuthRepository {
  final Dio _dio;
  AuthRepository() : _dio = ApiClient().dio;

  Future<Result<SignUpResModel>> register(SignUpReqModel signUpReqModel) async {
   String  errorMessage = ErrorMessages.registrationFailedError;
    try {
      final response = await _dio.post(
          '${ApiConstants.baseUrl}${ApiConstants.signUp}',
          data: signUpReqModel.toJson()
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final signUpResModel = SignUpResModel.fromJson(response.data);
        return Result.success(signUpResModel);
      } else {
        return Result.failure(response.data['message'] ?? errorMessage);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = ErrorMessages.connectionTimeOutError;
      }
      return Result.failure(errorMessage);
    } catch (e) {
      return Result.failure(ErrorMessages.somethingWentWrongError);
    }
  }

  Future<Result<LoginResModel>> login(LoginReqModel loginReqModel) async {
    String errorMessage = ErrorMessages.loginFailedError;
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.login}',
        data: loginReqModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginRes = LoginResModel.fromJson(response.data);
        return Result.success(loginRes);
      } else {
        return Result.failure(response.data['message'] ?? errorMessage);
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = ErrorMessages.connectionTimeOutError;
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = ErrorMessages.networkError;
      }
      return Result.failure(errorMessage);
    } catch (e) {
      return Result.failure(ErrorMessages.somethingWentWrongError);
    }
  }
}
