import 'package:child_health_story/core/constants/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:child_health_story/shared/widgets/text_widgets.dart';
import 'package:child_health_story/shared/widgets/image_selector_widget.dart';
import 'package:child_health_story/core/constants/color/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:child_health_story/shared/widgets/file_attachments_delete.dart';

typedef AttachmentChangeCallback = void Function({
  required List<XFile> newFiles,
  List<String>? removedExistingAttachments,
});


class AttachmentWidget extends StatefulWidget {
  final double maxFileSizeMB;
  final bool allowPdfSelection;
  final List<String>? existingAttachments; // made nullable
  final AttachmentChangeCallback? onFilesChanged;

  const AttachmentWidget({
    super.key,
    this.maxFileSizeMB = 10.0,
    this.allowPdfSelection = false,
    this.existingAttachments = const [], // default empty
    this.onFilesChanged,
  });

  @override
  State<AttachmentWidget> createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  final List<XFile> _selectedFiles = [];
  late List<String> _displayedExistingAttachments;
  final ImagePicker _picker = ImagePicker();
  final FilePicker _filePicker = FilePicker.platform;

  @override
  void initState() {
    super.initState();
    _displayedExistingAttachments = List<String>.from(widget.existingAttachments ?? []);
  }

  void _showSelectImageSheet(BuildContext context) {
    context.showImageSelector(
      onCameraSelected: () async {
        final picked = await _picker.pickImage(source: ImageSource.camera);
        if (picked != null) {
          _addImage(picked);
          if (context.mounted) Navigator.pop(context);
        }
      },
      onGallerySelected: () async {
        final picked = await _picker.pickImage(source: ImageSource.gallery);
        if (picked != null) {
          _addImage(picked);
          if (context.mounted) Navigator.pop(context);
        }
      },
      allowPdfSelection: widget.allowPdfSelection,
      onPdfSelected: () async {
        final result = await _filePicker.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        if (result != null && result.files.isNotEmpty) {
          final file = result.files.first;
          if (file.path != null) {
            final xFile = XFile(file.path!);
            _addImage(xFile);
            if (context.mounted) Navigator.pop(context);
          }
        }
      },
    );
  }

  void _addImage(XFile file) {
    setState(() {
      _selectedFiles.add(file);
    });
    _notifyFilesChanged();
  }

  void _removeNewFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
    _notifyFilesChanged();
  }

  void _removeExistingAttachment(int index) {
    setState(() {
      _displayedExistingAttachments.removeAt(index);
    });
    _notifyFilesChanged();
  }

  void _notifyFilesChanged() {
    widget.onFilesChanged?.call(
      newFiles: _selectedFiles,
      removedExistingAttachments: (widget.existingAttachments ?? [])
          .where((att) => !_displayedExistingAttachments.contains(att))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(2),
      color: AppColors.cwhiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidgets.textWidget(
                AppStrings.attachments,
                AppColors.cblackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Card(
                color: AppColors.appBackGroundColor,
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => _showSelectImageSheet(context),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Icon(Icons.upload_file, size: 40, color: AppColors.cblackColor),
                        ),
                        TextWidgets.textWidget(
                          AppStrings.uploadAFile,
                          AppColors.cblackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: TextWidgets.textWidget(
                            AppStrings.fileSizeLimit(widget.maxFileSizeMB),
                            AppColors.cblackColor,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            FileAttachmentsDelete(
              files: [
                ..._displayedExistingAttachments, // displayed if any, else empty
                ..._selectedFiles.map((file) => file.name),
              ],
              onDelete: (index) {
                if (index < _displayedExistingAttachments.length) {
                  _removeExistingAttachment(index);
                } else {
                  _removeNewFile(index - _displayedExistingAttachments.length);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
