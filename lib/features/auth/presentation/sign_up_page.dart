import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/features/auth/model/sing_up_model.dart';
import 'package:child_health_story/features/auth/presentation/bloc/sing_up_bloc.dart';
import 'package:child_health_story/features/auth/repository/auth_repository.dart';
import 'package:child_health_story/shared/widgets/custom_snack_bar.dart';
import 'package:child_health_story/shared/widgets/loader.dart';
import 'package:child_health_story/shared/widgets/parent_widget.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/path_constants.dart';
import '../../../core/constants/strings/validation_messages.dart';
import 'package:child_health_story/shared/widgets/text_input_widgets.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import '../../../core/utils/app_validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Loader.showLoader("Loading"),
            );
          } else if (state is RegisterSuccess) {
            Navigator.pop(context); // remove loader
            CustomSnackBar(
              context: context,
              message: state.message,
              messageType: AppStrings.success,
            ).show();
            Navigator.pushReplacementNamed(context, PathConstants.loginScreen);
          } else if (state is RegisterFailure) {
            Navigator.pop(context); // remove loader
            CustomSnackBar(
              context: context,
              message: state.error,
              messageType: AppStrings.failure,
            ).show();
          }
        },
        child: ParentWidget(
          context: context,
          hasHeader: false,
          childWidget: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textWidget(
                      AppStrings.letsGetStartedText,
                      AppColors.cblackColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    TextWidgets.textWidget(
                      AppStrings.createAccountDescriptionText,
                      AppColors.cblackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.firstNameHint,
                      TextInputType.text,
                      TextInputAction.done,
                      hintText: AppStrings.firstNameHint,
                      firstNameController,
                      validator: (value) =>
                      AppValidators.emptyValidator(value ?? '')
                          ? ValidationMessages.plsEnterFirstName
                          : null,
                      false,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.lastNameHint,
                      TextInputType.text,
                      TextInputAction.done,
                      hintText: AppStrings.lastNameHint,
                      lastNameController,
                      validator: (value) =>
                      AppValidators.emptyValidator(value ?? '')
                          ? ValidationMessages.plsEnterLastName
                          : null,
                      false,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.emailHint,
                      TextInputType.emailAddress,
                      TextInputAction.done,
                      hintText: AppStrings.emailHint,
                      emailController,
                      validator: (value) {
                        if (AppValidators.emptyValidator(value ?? '')) {
                          return ValidationMessages.plsEnterEmail;
                        } else if (AppValidators.emailValidator(value!)) {
                          return ValidationMessages.plsEnterValidEmail;
                        }
                        return null;
                      },
                      false,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.phoneHint,
                      TextInputType.phone,
                      TextInputAction.done,
                      hintText: AppStrings.phoneHint,
                      phoneController,
                      validator: (value) {
                        if (AppValidators.emptyValidator(value ?? '')) {
                          return ValidationMessages.plsEnterPhoneNumber;
                        } else if (AppValidators.phoneValidator(value!)) {
                          return ValidationMessages.plsEnterValidPhoneNumber;
                        }
                        return null;
                      },
                      false,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.passwordHint,
                      TextInputType.text,
                      TextInputAction.done,
                      hintText: AppStrings.passwordHint,
                      passwordController,
                      validator: (value) {
                        if (AppValidators.emptyValidator(value ?? '')) {
                          return ValidationMessages.plsEnterPassword;
                        } else if (AppValidators.strongPasswordValidator(value!)) {
                          return ValidationMessages.passwordPolicy;
                        }
                        return null;
                      },
                      false,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.confirmPasswordHint,
                      TextInputType.text,
                      TextInputAction.done,
                      hintText: AppStrings.confirmPasswordHint,
                      confirmPasswordController,
                      validator: (value) {
                        if (AppValidators.emptyValidator(value ?? '')) {
                          return ValidationMessages.plsEnterConfirmPassword;
                        } else if (AppValidators.confirmPasswordValidator(
                            passwordController.text, value!)) {
                          return ValidationMessages.passwordDoNotMatch;
                        }
                        return null;
                      },
                      false,
                    ),
                    ButtonWidgets.elevatedButton(
                      AppStrings.createMyAccountText,
                      AppColors.cprimaryColor,
                      AppColors.cwhiteColor,
                          () => _onSubmit(context),
                      width: AppUtils.getScreenWidth(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 50,
                      radius: 7,
                    ),
                    Center(
                      child: TextWidgets.termsAndPrivacyRichText(
                        firstText: AppStrings.signUpAgreement,
                        firstTextColor: AppColors.cblackColor,
                        firstTextFontSize: 16,
                        secondText: AppStrings.termsConditionsText,
                        secondTextColor: AppColors.cprimaryColor,
                        secondTextFontSize: 16,
                        thirdText: AppStrings.and,
                        thirdTextColor: AppColors.cblackColor,
                        thirdTextFontSize: 16,
                        fourthText: AppStrings.privacyPolicyText,
                        fourthTextColor: AppColors.cprimaryColor,
                        fourthTextFontSize: 16,
                        onSecondTextTap: () {/* handle terms tap */},
                        onFourthTextTap: () {/* handle privacy tap */},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final signUpReqModel = SignUpReqModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim(),
        deviceId: "",
      );
      context.read<SignUpBloc>().add(
        RegisterSubmitted(
          firstName: signUpReqModel.firstName,
          lastName: signUpReqModel.lastName,
          email: signUpReqModel.email,
          phone: signUpReqModel.phone,
          password: signUpReqModel.password,
          deviceId: signUpReqModel.deviceId,
        ),
      );
    }
  }
}
