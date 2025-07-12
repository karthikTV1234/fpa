import 'package:flutter_test/flutter_test.dart';
import 'package:child_health_story/core/utils/app_validators.dart';

void main() {
  group('AppValidators', () {
    test('emailValidator returns true for invalid emails and false for valid emails', () {
      expect(AppValidators.emailValidator('invalidemail'), true);
      expect(AppValidators.emailValidator('invalid@'), true);
      expect(AppValidators.emailValidator('test@gmail.com'), false);
    });

    test('nameValidator returns true for invalid names and false for valid names', () {
      expect(AppValidators.nameValidator(''), true);
      expect(AppValidators.nameValidator('John123'), false);
      expect(AppValidators.nameValidator('John Doe'), false);
      expect(AppValidators.nameValidator('John@Doe'), true);
    });

    test('phoneValidator returns true for invalid phone numbers and false for valid phone numbers', () {
      expect(AppValidators.phoneValidator('12345'), true);
      expect(AppValidators.phoneValidator('9876543210'), false);
      expect(AppValidators.phoneValidator('5876543210'), true);
    });

    test('passwordValidator returns true for weak passwords and false for valid passwords', () {
      expect(AppValidators.passwordValidator('password'), true); // weak
      expect(AppValidators.passwordValidator('Password@123'), false); // valid
    });

    test('emptyValidator returns true for empty or null and false for non-empty', () {
      expect(AppValidators.emptyValidator(''), true);
      expect(AppValidators.emptyValidator(null), true);
      expect(AppValidators.emptyValidator('abc'), false);
    });

    test('matchValidator returns true if values do not match, false if they match', () {
      expect(AppValidators.matchValidator('abc', 'abc'), false);
      expect(AppValidators.matchValidator('abc', 'def'), true);
    });

    test('lengthValidator returns true if length < 6, false otherwise', () {
      expect(AppValidators.lengthValidator('123'), true);
      expect(AppValidators.lengthValidator('123456'), false);
    });

    test('strongPasswordValidator returns true for weak passwords and false for strong passwords', () {
      expect(AppValidators.strongPasswordValidator('weakpass'), true);
      expect(AppValidators.strongPasswordValidator('Strong@123'), false);
    });

    test('confirmPasswordValidator returns true if passwords do not match, false if they match', () {
      expect(AppValidators.confirmPasswordValidator('pass', 'pass'), false);
      expect(AppValidators.confirmPasswordValidator('pass1', 'pass2'), true);
    });
  });
}
