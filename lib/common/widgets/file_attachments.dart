import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class FileAttachments extends StatefulWidget {
  final List<dynamic> files;
  const FileAttachments({super.key, required this.files});

  @override
  State<FileAttachments> createState() => _FileAttachmentsState();
}

class _FileAttachmentsState extends State<FileAttachments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.files.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: AppColors.vLightGreyColor,
              borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Icon(
                    Icons.copy_rounded,
                    size: 14.0,
                    color: AppColors.cblackColor,
                  ),
                  TextWidgets.textWidget(
                      widget.files[index], AppColors.cblackColor,
                      fontSize: 14, fontWeight: FontWeight.w400),
                ],
              ),
              ButtonWidgets.getIconButton(
                  Icon(
                    Icons.remove_red_eye_outlined,
                    size: 16.0,
                    color: AppColors.lightPrimaryColor,
                  ),
                  () {})
            ],
          ),
        );
      },
    );
  }
}
