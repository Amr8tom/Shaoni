import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/generated/l10n.dart';
import 'dart:io';
import 'dart:convert';

class FileUploadWidget extends StatefulWidget {
  /// Callback to return the file name and base64 string to the parent.
  /// Returns null when the user removes the file.
  final void Function(String? fileName, String? base64String)? onPickedFile;

  const FileUploadWidget({super.key, this.onPickedFile});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  PlatformFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Upload section title
        Text(
          S.current.attachments,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Sizer(height: 16),

        /// Upload box
        GestureDetector(
          onTap: () async {
            try {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'pdf',
                  'doc',
                  'docx',
                  'jpg',
                  'jpeg',
                  'png',
                  'xlsx',
                  'xls'
                ],
              );

              if (result != null && result.files.single.path != null) {
                try {
                  final file = File(result.files.single.path!);
                  final fileBytes = await file.readAsBytes();
                  final base64String = base64Encode(fileBytes);

                  setState(() {
                    _pickedFile = result.files.single;
                  });

                  if (widget.onPickedFile != null) {
                    widget.onPickedFile!(_pickedFile!.name, base64String);
                  }
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.current.error),
                      backgroundColor: ColorRes.error,
                    ),
                  );
                }
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.current.error),
                  backgroundColor: ColorRes.error,
                ),
              );
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSizes.padding * 1.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorRes.primary.withValues(alpha: 0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              color: ColorRes.primary.withValues(alpha: 0.05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 48,
                  color: ColorRes.primary,
                ),
                const Sizer(height: 12),
                Text(
                  S.current.uploadFileSelect,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorRes.primary,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
                const Sizer(height: 8),
              ],
            ),
          ),
        ),

        /// Display selected file
        if (_pickedFile != null) ...[
          const Sizer(height: 16),
          Container(
            padding: EdgeInsets.all(AppSizes.padding),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorRes.grey2.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              color: ColorRes.grey6,
            ),
            child: Row(
              children: [
                Icon(
                  _getFileIcon(_pickedFile!.extension ?? ''),
                  color: ColorRes.primary,
                  size: 32,
                ),
                const Sizer(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _pickedFile!.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _formatFileSize(_pickedFile!.size),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorRes.grey2.withValues(alpha: 0.6),
                            ),
                      ),
                    ],
                  ),
                ),

                /// Remove button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pickedFile = null;
                    });

                    /// NOTIFY PARENT THAT FILE WAS REMOVED
                    if (widget.onPickedFile != null) {
                      widget.onPickedFile!(null, null);
                    }
                  },
                  child: Icon(
                    Icons.close,
                    color: ColorRes.grey2.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'xlsx':
      case 'xls':
        return Icons.table_chart;
      default:
        return Icons.attach_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}
