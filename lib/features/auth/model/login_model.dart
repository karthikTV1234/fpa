class LoginReqModel {
  final String email;
  final String password;
  final String deviceId;

  LoginReqModel({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  // Factory constructor to create LoginReqModel from JSON
  factory LoginReqModel.fromJson(Map<String, dynamic> json) {
    return LoginReqModel(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceId: json['device_id'] as String,
    );
  }

  // Method to convert LoginReqModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_id': deviceId,
    };
  }
}

class LoginResModel {
  final String accessToken;

  LoginResModel({required this.accessToken});

  factory LoginResModel.fromJson(Map<String, dynamic> json) {
    return LoginResModel(
      accessToken: json['access_token'] ?? '',
    );
  }
}
