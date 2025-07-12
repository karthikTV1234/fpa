import 'package:child_health_story/features/auth/presentation/bloc/login_otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:child_health_story/core/constants/strings/validation_messages.dart';
import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/core/utils/app_utils.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/loader.dart';
import 'package:child_health_story/shared/widgets/parent_widget.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:child_health_story/shared/widgets/custom_snack_bar.dart';

class OtpScreen extends StatefulWidget {
  final String? firebaseVerificationId;
  final bool isFromForgotPassword;

  const OtpScreen({
    super.key,
    this.firebaseVerificationId,
    this.isFromForgotPassword = false,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 68,
    height: 71,
    textStyle: TextStyle(
      color: AppColors.cblackColor,
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    decoration: BoxDecoration(
      color: AppColors.cwhiteColor,
      borderRadius: BorderRadius.circular(13.0),
    ),
  );

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginOtpBloc, LoginOtpState>(
        listener: (context, state) {
          if (state is LoginOtpLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Loader.showLoader("Verifying OTP..."),
            );
          } else {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // hide loader
            }
          }

          if (state is LoginOtpSuccess) {
            if (widget.isFromForgotPassword) {
              Navigator.pushReplacementNamed(
                context,
                PathConstants.changePasswordScreen,
                arguments: widget.isFromForgotPassword,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PathConstants.addchild,
                    (route) => false,
              );
            }
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
          childWidget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: AppUtils.getScreenHeight(context),
                ),
                child: IntrinsicHeight(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textWidget(
                        AppStrings.verifyAccountText,
                        AppColors.cblackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                      TextWidgets.textWidget(
                        AppStrings.enterOtpText,
                        AppColors.cblackColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                      TextWidgets.textWidget(
                        AppStrings.sentOtpText,
                        AppColors.cblackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Pinput(
                          length: 6,
                          controller: _otpController,
                          defaultPinTheme: defaultPinTheme,
                        ),
                      ),
                      ButtonWidgets.elevatedButton(
                        radius: 7,
                        height: 50,
                        width: AppUtils.getScreenWidth(context),
                        AppStrings.verifyMyAccountText,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        AppColors.cprimaryColor,
                        AppColors.cwhiteColor,
                            () {
                          if (_otpController.text.trim().length < 6) {
                            CustomSnackBar(
                              context: context,
                              message: ValidationMessages.plsEnterOTP,
                              messageType: AppStrings.failure,
                            ).show();
                            return;
                          }

                          context.read<LoginOtpBloc>().add(
                            AuthSubmitOtp(
                              otp: _otpController.text.trim(),
                              verificationId:
                              widget.firebaseVerificationId ?? '',
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextWidgets.richText(
                          AppStrings.didReceiveText,
                          AppColors.cblackColor,
                          14.0,
                          AppStrings.resendOtpText,
                          AppColors.cprimaryColor,
                          14.0,
                          rTextFontWeight: FontWeight.bold,
                          rDecoration: TextDecoration.none,
                          isRTextClickable: true,
                          rDecorationColor: AppColors.cprimaryColor,
                          onRTextTap: () {
                            // Future enhancement: Add resend OTP functionality
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextWidgets.richText(
                          AppStrings.wantToUpdateText,
                          AppColors.cblackColor,
                          14.0,
                          AppStrings.clickHereText,
                          AppColors.cprimaryColor,
                          14.0,
                          rTextFontWeight: FontWeight.bold,
                          rDecoration: TextDecoration.none,
                          isRTextClickable: true,
                          rDecorationColor: AppColors.cprimaryColor,
                          onRTextTap: () {
                            // Future enhancement: Add update phone number functionality
                          },
                        ),
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
