import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.openweathermap.org/data/2.5/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ));

    // Optional: Add token/auth headers globally
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     options.headers['Authorization'] = 'Bearer YOUR_TOKEN';
    //     return handler.next(options);
    //   },
    // ));
  }
}
