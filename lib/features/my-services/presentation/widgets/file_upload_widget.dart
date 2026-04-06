import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/generated/l10n.dart';
import '../controller/request_services/request_service_cubit.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({super.key});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  PlatformFile? _pickedFile;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'xlsx', 'xls'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _pickedFile = result.files.single;
        });

        // Optional: Update controller with file path
        final controller = context.read<RequestServiceCubit>();
        // You can add a method in controller to store file path if needed
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.error ?? 'Error picking file'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSizes.padding * 1.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorRes.primary.withOpacity(0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              color: ColorRes.primary.withOpacity(0.05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Upload icon
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 48,
                  color: ColorRes.primary,
                ),
                const Sizer(height: 12),

                /// Upload text
                Text(
                    'Select File to Upload',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorRes.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Sizer(height: 8),

                /// Support formats
                // Text(
                //   S.current.supportedFormats ?? 'PDF, DOC, DOCX, JPG, PNG, XLSX',
                //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                //     color: ColorRes.grey2.withOpacity(0.6),
                //   ),
                //   textAlign: TextAlign.center,
                // ),
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
                color: ColorRes.grey2.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              color: ColorRes.grey6,
            ),
            child: Row(
              children: [
                /// File icon
                Icon(
                  _getFileIcon(_pickedFile!.extension ?? ''),
                  color: ColorRes.primary,
                  size: 32,
                ),
                const Sizer(width: 12),

                /// File info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// File name
                      Text(
                        _pickedFile!.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      /// File size
                      Text(
                        _formatFileSize(_pickedFile!.size),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorRes.grey2.withOpacity(0.6),
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
                  },
                  child: Icon(
                    Icons.close,
                    color: ColorRes.grey2.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// Get appropriate icon based on file extension
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

  /// Format file size to readable format
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
  }
}

