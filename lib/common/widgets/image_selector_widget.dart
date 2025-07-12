import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import '../../core/constants/color/app_colors.dart';
import '../../core/constants/strings/app_strings.dart';

class ImageSelectorWidget extends StatelessWidget {
  final VoidCallback onCameraSelected;
  final VoidCallback onGallerySelected;
  final VoidCallback? onPdfSelected;
  final bool allowPdfSelection;

  const ImageSelectorWidget({
    super.key,
    required this.onCameraSelected,
    required this.onGallerySelected,
    this.onPdfSelected,
    this.allowPdfSelection = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onCameraSelected,
                  icon: const Icon(Icons.camera),
                ),
                TextWidgets.textWidget(
                  AppStrings.cameraText,
                  AppColors.cblackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: onGallerySelected,
                  icon: const Icon(Icons.browse_gallery),
                ),
                TextWidgets.textWidget(
                  AppStrings.galleryText,
                  AppColors.cblackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          if (allowPdfSelection)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onPdfSelected,
                    icon: const Icon(Icons.picture_as_pdf),
                  ),
                  TextWidgets.textWidget(
                    AppStrings.pdfText,
                    AppColors.cblackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Extension to show the image selector bottom sheet
extension ImageSelectorExtension on BuildContext {
  Future<void> showImageSelector({
    required VoidCallback onCameraSelected,
    required VoidCallback onGallerySelected,
    VoidCallback? onPdfSelected,
    bool allowPdfSelection = false,
  }) async {
    await showModalBottomSheet(
      context: this,
      builder: (context) => ImageSelectorWidget(
        onCameraSelected: onCameraSelected,
        onGallerySelected: onGallerySelected,
        onPdfSelected: onPdfSelected,
        allowPdfSelection: allowPdfSelection,
      ),
    );
  }
}
