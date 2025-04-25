import 'package:dio/dio.dart';
import '../constants/ApiConstants.dart';
import 'interceptor/token_interceptor.dart';
import 'interceptor/token_manager.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late final Dio dio;
  late final TokenManager tokenManager;

  ApiClient._internal() {
    tokenManager = TokenManager();  // Initialize the TokenManager
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ));

    //Add auth token interceptor and refresh token on 401
    dio.interceptors.add(TokenInterceptor(tokenManager));
  }
}
