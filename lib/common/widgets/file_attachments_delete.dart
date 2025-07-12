import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:child_health_story/shared/widgets/button_widgets.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class FileAttachmentsDelete extends StatelessWidget {
  final List<dynamic> files;
  final void Function(int index)? onDelete;

  const FileAttachmentsDelete({
    super.key,
    required this.files,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: files.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 6.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.vLightGreyColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
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
                    files[index],
                    AppColors.cblackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              ButtonWidgets.getIconButton(
                Icon(
                  Icons.delete_outline,
                  size: 16.0,
                  color: Colors.red[400],
                ),
                    () => onDelete?.call(index),
              ),
            ],
          ),
        );
      },
    );
  }
}