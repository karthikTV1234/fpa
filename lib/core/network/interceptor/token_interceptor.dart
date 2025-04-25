import 'package:dio/dio.dart';
import 'package:fpa/core/network/interceptor/token_manager.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final TokenManager tokenManager;

  TokenInterceptor(this.tokenManager);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Check if the request requires authentication by looking for the 'authRequired' flag
    final authRequired = options.extra['authRequired'] ?? true;  // Default to true if not provided

    if (authRequired) {
      // If auth is required, fetch the current token
      final token = await tokenManager.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';  // Add token to headers
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioException e, ErrorInterceptorHandler handler) async {
    // If we get a 401 Unauthorized error, try to refresh the token
    if (e.response?.statusCode == 401) {
      // Attempt to refresh the token
      final newToken = await tokenManager.refreshToken();

      if (newToken != null) {
        // Save the new token
        await tokenManager.saveToken(newToken);

        // Retry the failed request with the new token
        final options = e.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        // Retry the request and return the successful response
        final retryResponse = await Dio().fetch(options);
        return handler.resolve(retryResponse);
      }
    }
    // If we can't refresh the token, propagate the error
    return super.onError(e, handler);
  }
}
