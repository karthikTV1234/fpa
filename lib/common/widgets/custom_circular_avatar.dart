import 'dart:io';
import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_selector_widget.dart';

// ignore: must_be_immutable
class CustomCircleAvatar extends StatelessWidget {
  final picker = ImagePicker();
  File? imageFile;
  final BuildContext mainContext;
  final bool showCamera;
  final Function(File, String) callback;
  CustomCircleAvatar(
      {super.key,
      this.imageFile,
      required this.mainContext,
      this.showCamera = false,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageFile != null
            ? CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(imageFile!),
              )
            : CircleAvatar(
                radius: 80,
                child: Icon(Icons.person),
              ),
        showCamera
            ? Positioned(
                top: 10,
                right: 10,
                // right: 0,
                // bottom: 15,
                child: InkWell(
                  onTap: () {
                    _selectImage(mainContext);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.47),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.cwhiteColor,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }

  Future<void> _getImage(
      ImageSource source, BuildContext modelSheetContext) async {
    XFile? selectedImage = await picker.pickImage(source: source);

    if (selectedImage != null) {
      imageFile = File(selectedImage.path);
      if (modelSheetContext.mounted) {
        Navigator.pop(modelSheetContext);
      }

      callback(imageFile!, selectedImage.name);
    }
  }

  void _selectImage(BuildContext context) {
    context.showImageSelector(
      onCameraSelected: () async => await _getImage(ImageSource.camera, context),
      onGallerySelected: () async => await _getImage(ImageSource.gallery, context),
    );
  }

}
