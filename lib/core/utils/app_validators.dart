class AppValidators {
  static bool emailValidator(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(email.toString())) {
      return true;
    }
    return false;
  }

  static bool nameValidator(String name) {
    RegExp nameRegExp = RegExp(r"^[a-zA-Z0-9]+(?: [a-zA-Z0-9]+)*$");
    if (!nameRegExp.hasMatch(name)) {
      return true;
    }
    return false;
  }

  static bool phoneValidator(String value) {
    RegExp mobileRegExp = RegExp(r'^[6-9]\d{9}$');
    if (!mobileRegExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool passwordValidator(String value) {
    final RegExp passwordRegExp =
        RegExp(r'^(?=.*[A-Z])(?=.*[\W_])(?=.*[a-zA-Z0-9]).{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool matchValidator(String value1, String value2) {
    if (value1 != value2) {
      return true;
    }
    return false;
  }

  static bool lengthValidator(String value) {
    if (value.length < 6) {
      return true;
    }
    return false;
  }

  static bool strongPasswordValidator(String value) {
    // At least 8 characters, one uppercase, one lowercase, one digit, one special character
    RegExp strongPassRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$'
    );
    return !strongPassRegExp.hasMatch(value);
  }

  static bool confirmPasswordValidator(String password, String confirmPassword) {
    return password != confirmPassword;
  }
}
