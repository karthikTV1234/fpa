import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import 'package:child_health_story/core/utils/app_validators.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/parent_widget.dart';
import 'package:child_health_story/shared/widgets/text_input_widgets.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
        context: context,
        childWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: AppUtils.getScreenHeight(context)),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textWidget(
                        AppStrings.welcomeText,
                        AppColors.cblackColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.left,
                      ),
                      TextWidgets.textWidget(
                        AppStrings.enterEmailOrPwdtext,
                        AppColors.cblackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                      ),
                      TextInputWidgets.textFormField(
                          "${AppStrings.emailLabel}/ ${AppStrings.phoneLabel}",
                          TextInputType.text,
                          TextInputAction.done,
                          hintText: AppStrings.eamilOrPhoneHintText,
                          _emailController, validator: (value) {
                        if (AppValidators.emptyValidator(value!)) {
                          return ValidationMessages.emailReq;
                        } else if (AppValidators.emailValidator(value)) {
                          return ValidationMessages.invalidEmail;
                        }

                        return null;
                      }, false),
                      TextInputWidgets.textFormField(
                          AppStrings.passwordtext,
                          TextInputType.text,
                          TextInputAction.done,
                          hintText: AppStrings.passwordHintText,
                          _passwordController, validator: (value) {
                        if (AppValidators.emptyValidator(value!)) {
                          return ValidationMessages.passwordReq;
                        }
                        return null;
                      }, true),
                      ButtonWidgets.elevatedButton(AppStrings.continueText,
                          AppColors.cprimaryColor, AppColors.cwhiteColor, () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, PathConstants.addchild);
                        }
                      },
                          width: AppUtils.getScreenWidth(context),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 50,
                          radius: 7),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextWidgets.richText(
                            AppStrings.signInUsingText,
                            AppColors.cblackColor,
                            16.0,
                            AppStrings.mobileNumberText,
                            AppColors.cprimaryColor,
                            16.0,
                            rTextFontWeight: FontWeight.bold,
                            rDecoration: TextDecoration.underline,
                            isRTextClickable: true,
                            rDecorationColor: AppColors.cprimaryColor,
                            onRTextTap: () {
                          Navigator.pushNamed(
                              context, PathConstants.loginWithOtp);
                        }),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ButtonWidgets.textButton(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            AppStrings.forgotPasswordText,
                            AppColors.cblackColor,
                            () {
                              Navigator.pushNamed(
                                  context, PathConstants.forgotPasswordScreen);
                            }),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextWidgets.richText(
                            AppStrings.dontHaveAccountText,
                            AppColors.cblackColor,
                            16.0,
                            AppStrings.signUpText,
                            AppColors.cprimaryColor,
                            16.0,
                            rTextFontWeight: FontWeight.bold,
                            rDecoration: TextDecoration.none,
                            isRTextClickable: true,
                            rDecorationColor: AppColors.cprimaryColor,
                            onRTextTap: () {
                          Navigator.pushNamed(
                              context, PathConstants.signUpScreen);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        hasHeader: false);
  }
}
