import 'package:child_health_story/features/auth/presentation/bloc/login_otp_bloc.dart';
import 'package:child_health_story/shared/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import 'package:child_health_story/core/utils/app_validators.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/loader.dart';
import 'package:child_health_story/shared/widgets/parent_widget.dart';
import 'package:child_health_story/shared/widgets/text_input_widgets.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'args/otp_screen_args.dart';

class LoginWithOtp extends StatefulWidget {
  const LoginWithOtp({super.key});

  @override
  State<LoginWithOtp> createState() => _LoginWithOtpState();
}

class _LoginWithOtpState extends State<LoginWithOtp> {
  final TextEditingController _emailOrMobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginOtpBloc, LoginOtpState>(
        listener: (context, state) {
          if (state is LoginOtpLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Loader.showLoader("Requesting OTP..."),
            );
          } else {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // dismiss loader
            }
          }

          if (state is OtpSent) {
            Navigator.pushNamed(
              context,
              PathConstants.otpScreen,
              arguments: OtpScreenArgs(
                verificationId: state.verificationId,
              ),
            );
          }

          if (state is LoginOtpError) {
            CustomSnackBar(
              context: context,
              message: state.message,
              messageType: AppStrings.failure,
            ).show();
          }
        },
        child: ParentWidget(
          context: context,
          hasHeader: false,
          childWidget: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: AppUtils.getScreenHeight(context)),
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
                          _emailOrMobileNumberController,
                          validator: (value) {
                            if (AppValidators.emptyValidator(value!)) {
                              return ValidationMessages.emailOrPhoneNumberReq;
                            }
                            return null;
                          },
                          false,
                        ),
                        ButtonWidgets.elevatedButton(
                          AppStrings.continueText,
                          AppColors.cprimaryColor,
                          AppColors.cwhiteColor,
                              () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginOtpBloc>().add(
                                AuthRequestOtp(
                                  _emailOrMobileNumberController.text.trim(),
                                ),
                              );
                            }
                          },
                          width: AppUtils.getScreenWidth(context),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          height: 50,
                          radius: 7,
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
                            onRTextTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
