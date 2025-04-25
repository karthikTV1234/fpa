import 'package:dio/dio.dart';

class TokenManager {
  // Fetch the current token from secure storage
  Future<String?> getToken() async {
    return "hgr45fdserthhgtkkhhgfddert";
  }

  // Save the new token to secure storage
  Future<void> saveToken(String token) async {

  }

  // Refresh the token (make an API call to refresh token)
  Future<String?> refreshToken() async {
    try {
      final response = await Dio().post(
        '/refresh-token', // Replace with your refresh token API endpoint
        data: {'refresh_token': 'your_refresh_token_here'}, // Payload for refreshing
      );
      if (response.statusCode == 200) {
        return response.data['new_token'];  // Extract the new token
      }
    } catch (e) {
      return null; // Return null if refresh fails
    }
    return null;
  }
}
