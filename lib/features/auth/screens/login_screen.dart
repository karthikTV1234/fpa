import 'package:flutter/material.dart';
import 'package:fpa/common/widgets/button_widgets.dart';
import 'package:fpa/common/widgets/text_input_widgets.dart';
import 'package:fpa/common/widgets/text_style_widget.dart';
import 'package:fpa/core/constants/color/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    spacing: 16,
                    children: [
                      // Username field
                      TextInputWidgets.textFormField(
                        'Username',
                        'Enter your username',
                        TextInputType.text,
                        TextInputAction.next,
                        _usernameController,
                        false,
                        validator: _validateUsername,
                        labelFontSize: 16,
                        hintFontSize: 14,
                      ),
                      // Password field
                      TextInputWidgets.textFormField(
                        'Password',
                        'Enter your password',
                        TextInputType.visiblePassword,
                        TextInputAction.done,
                        _passwordController,
                        _obscurePassword,
                        validator: _validatePassword,
                        labelFontSize: 16,
                        hintFontSize: 14,
                      ),
                      // Login button
                      ButtonWidgets.elevatedButton(
                        'Login',
                        AppColors.cblackColor,
                        Colors.white,
                        _login,
                        height: 50,
                        width: double.infinity,
                        radius: 8,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        btnPadding: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
