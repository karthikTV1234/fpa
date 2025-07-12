import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import 'package:child_health_story/core/utils/app_validators.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/parent_widget.dart';
import 'package:child_health_story/shared/widgets/text_input_widgets.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/path_constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final bool isFromForgotPassword = args is bool ? args : false;
    return ParentWidget(
      hasHeader: false,
      context: context,
      childWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: AppUtils.getScreenHeight(context)),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidgets.textWidget(
                      AppStrings.changePasswordText,
                      AppColors.cblackColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.left,
                    ),
                    if (!isFromForgotPassword)
                      TextInputWidgets.textFormField(
                        AppStrings.oldPasswordText,
                        TextInputType.text,
                        TextInputAction.next,
                        hintText: AppStrings.oldPasswordHint,
                        _oldPasswordController,
                        validator: (value) {
                          if (AppValidators.emptyValidator(value!)) {
                            return ValidationMessages.plsEnterOldPassword;
                          }
                          return null;
                        },
                        true,
                      ),
                    TextInputWidgets.textFormField(
                      AppStrings.newPasswordText,
                      TextInputType.text,
                      TextInputAction.next,
                      hintText: AppStrings.newPasswordHint,
                      _newPasswordController,
                      validator: (value) {
                        if (AppValidators.emptyValidator(value!)) {
                          return ValidationMessages.plsEnterNewPassword;
                        } else if (AppValidators.strongPasswordValidator(value)) {
                          return ValidationMessages.passwordPolicy;
                        }
                        return null;
                      },
                      true,
                    ),
                    TextInputWidgets.textFormField(
                      AppStrings.confirmNewPasswordText,
                      TextInputType.text,
                      TextInputAction.done,
                      hintText: AppStrings.confirmNewPasswordText,
                      _confirmPasswordController,
                      validator: (value) {
                        if (AppValidators.emptyValidator(value!)) {
                          return ValidationMessages.plsReEnterNewPassword;
                        } else if (AppValidators.confirmPasswordValidator(
                          _newPasswordController.text,
                          value,
                        )) {
                          return ValidationMessages.passwordDoNotMatch;
                        }
                        return null;
                      },
                      true,
                    ),
                    ButtonWidgets.elevatedButton(
                      AppStrings.saveText,
                      AppColors.cprimaryColor,
                      AppColors.cwhiteColor,
                      () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(
                              context, PathConstants.loginScreen
                          );
                        }
                      },
                      width: AppUtils.getScreenWidth(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 50,
                      radius: 7,
                    ),
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
