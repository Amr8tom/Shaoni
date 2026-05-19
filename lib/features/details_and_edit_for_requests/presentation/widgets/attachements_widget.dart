import 'package:flutter/material.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/helpers/base64_file_helper.dart';
import '../../../../generated/l10n.dart';

/// Renders the "Attachments" section inside the request details screen.
///
/// Behavior:
///   - The base64 string coming from the API can be ANY file type
///     (image, PDF, Word, Excel, PowerPoint, ...). We don't preview it
///     anymore — we offer a clean "download" affordance that triggers
///     the native iOS / Android share sheet so the user can save it.
///   - The file type is detected from the data-URI prefix when present,
///     otherwise from the binary "magic bytes" of the decoded payload.
class LeavesAttachmentWidget extends StatefulWidget {
  final String leavesAttachment;

  const LeavesAttachmentWidget({super.key, required this.leavesAttachment});

  @override
  State<LeavesAttachmentWidget> createState() => _LeavesAttachmentWidgetState();
}

class _LeavesAttachmentWidgetState extends State<LeavesAttachmentWidget> {
  Base64FileInfo? _info;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _info = Base64FileHelper.detect(widget.leavesAttachment);
  }

  @override
  void didUpdateWidget(covariant LeavesAttachmentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.leavesAttachment != widget.leavesAttachment) {
      _info = Base64FileHelper.detect(widget.leavesAttachment);
    }
  }

  Future<void> _handleDownload() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    final result = await Base64FileHelper.downloadAndShare(
      base64String: widget.leavesAttachment,
    );

    if (!mounted) return;
    setState(() => _isDownloading = false);

    /// Map each outcome to a tailored snackbar.
    String message;
    Color background;
    switch (result.status) {
      case DownloadStatus.shared:
        message = S.current.success;
        background = ColorRes.success;
        break;
      case DownloadStatus.savedOnly:
        /// Plugin not linked / share sheet failed — the file IS on disk.
        message = result.filePath != null
            ? 'Saved to: ${result.filePath}'
            : S.current.success;
        background = ColorRes.warning;
        break;
      case DownloadStatus.failure:
        message = S.current.error;
        background = ColorRes.error;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: background,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// If the API returned an empty attachment, render nothing — the
    /// parent already gates this widget but we double-guard here.
    if (widget.leavesAttachment.isEmpty || _info == null) {
      return const Sizer();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: ColorRes.grey4),
        const Sizer(height: 16),

        /// Section header — "Attachments"
        Row(
          children: [
            Icon(
              Icons.attach_file_rounded,
              color: ColorRes.primary,
              size: AppSizes.iconMd,
            ),
            const Sizer(width: 8),
            Text(
              S.current.attachments,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorRes.primary,
                    fontSize: AppSizes.fontSizeSm,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
        const Sizer(height: 12),

        /// File card
        _AttachmentFileCard(
          info: _info!,
          isDownloading: _isDownloading,
          onDownload: _handleDownload,
        ),

        const Sizer(height: 8),
      ],
    );
  }
}

/// Modern file card — leading typed icon, file label + size in the middle,
/// trailing download action with an inline progress spinner.
class _AttachmentFileCard extends StatelessWidget {
  const _AttachmentFileCard({
    required this.info,
    required this.isDownloading,
    required this.onDownload,
  });

  final Base64FileInfo info;
  final bool isDownloading;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onDownload,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        child: Container(
          padding: EdgeInsets.all(AppSizes.padding * 0.9),
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            border: Border.all(
              color: info.color.withOpacity(0.20),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: info.color.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              /// Leading file-type icon — colored by the detected MIME.
              Container(
                width: AppSizes.iconLg * 1.6,
                height: AppSizes.iconLg * 1.6,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: info.color.withOpacity(0.12),
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusMd),
                  border: Border.all(
                    color: info.color.withOpacity(0.20),
                    width: 1,
                  ),
                ),
                child: Icon(
                  info.icon,
                  color: info.color,
                  size: AppSizes.iconLg,
                ),
              ),
              const Sizer(width: 12),

              /// File metadata — label + size + extension chip.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      info.label,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                            color: ColorRes.black,
                            fontWeight: FontWeight.w700,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Sizer(height: 4),
                    Row(
                      children: [
                        /// Extension chip
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: info.color.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(
                                AppSizes.borderRadiusSm),
                          ),
                          child: Text(
                            info.extension.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: info.color,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10,
                                ),
                          ),
                        ),
                        const Sizer(width: 6),
                        /// Bullet separator
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: ColorRes.grey2,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Sizer(width: 6),
                        /// File size
                        Text(
                          Base64FileHelper.formatSize(info.sizeInBytes),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: ColorRes.grey2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Sizer(width: 8),

              /// Trailing download / loading indicator
              Container(
                width: AppSizes.iconLg * 1.4,
                height: AppSizes.iconLg * 1.4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorRes.primary,
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: ColorRes.primary.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: isDownloading
                    ? SizedBox(
                        width: AppSizes.iconMd,
                        height: AppSizes.iconMd,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(
                        Icons.download_rounded,
                        color: ColorRes.white,
                        size: AppSizes.iconMd,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
