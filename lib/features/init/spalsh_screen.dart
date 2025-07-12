import 'dart:async';
import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/core/constants/path_constants.dart';
import 'package:child_health_story/shared/widgets/parent_widget.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/widgets.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, PathConstants.loginScreen, (Route<dynamic> route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
        context: context,
        childWidget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: TextWidgets.textWidget("CHS", AppColors.cblackColor,
                    textAlign: TextAlign.center,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        hasHeader: false);
  }
}
