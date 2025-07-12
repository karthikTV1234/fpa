class SignUpReqModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String deviceId;

  SignUpReqModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.deviceId,
  });

  // Factory constructor to create a UserModel from a JSON map
  factory SignUpReqModel.fromJson(Map<String, dynamic> json) {
    return SignUpReqModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      deviceId: json['device_id'] as String,
    );
  }

  // Method to convert the UserModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'device_id': deviceId,
    };
  }
}

class SignUpResModel {
  final String message;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String token;

  SignUpResModel({
    required this.message,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.token,
  });

  factory SignUpResModel.fromJson(Map<String, dynamic> json) {
    return SignUpResModel(
      message: json['message'] ?? '',
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
