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

import 'args/otp_screen_args.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      hasHeader: false,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textWidget(
                      AppStrings.forgotPasswordHeadText,
                      AppColors.cblackColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.left,
                    ),
                    TextWidgets.textWidget(
                      AppStrings.sendEmail,
                      AppColors.cblackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 16),
                    TextInputWidgets.textFormField(
                        AppStrings.emailHint,
                        hintText: AppStrings.emailHint,
                        TextInputType.text,
                        TextInputAction.done,
                        _emailController, validator: (value) {
                      if (AppValidators.emptyValidator(value!)) {
                        return ValidationMessages.plsEnterEmail;
                      } else if (AppValidators.emailValidator(value)) {
                        return ValidationMessages.plsEnterValidEmail;
                      }

                      return null;
                    }, false),
                    SizedBox(height: 16),
                    ButtonWidgets.elevatedButton(AppStrings.shareOTPText,
                        AppColors.cprimaryColor, AppColors.cwhiteColor, () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(
                          context,
                          PathConstants.otpScreen,
                          arguments: OtpScreenArgs(
                            isFromForgotPassword: true,
                          ),
                        );
                      }
                    },
                        width: AppUtils.getScreenWidth(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 50,
                        radius: 7),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
