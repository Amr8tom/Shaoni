import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/models/request_attachment.dart';
import '../../../../generated/l10n.dart';
import 'attachements_widget.dart';

/// Centralized attachments renderer for the request-details screen.
///
/// Renders a list of [RequestAttachment] under a single "Attachments" header:
///   - URL attachments → inline image preview (for images) + tap-to-open.
///   - base64 attachments → the existing download card ([LeavesAttachmentWidget]).
///
/// Renders nothing when the list is empty, so callers can drop it in
/// unconditionally.
class AttachmentsView extends StatelessWidget {
  const AttachmentsView({super.key, required this.attachments});

  final List<RequestAttachment> attachments;

  @override
  Widget build(BuildContext context) {
    final items = attachments
        .where((a) => a.hasUrl || a.hasBase64)
        .toList(growable: false);
    if (items.isEmpty) return const Sizer();

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

        for (final a in items)
          a.hasUrl
              ? _UrlAttachmentCard(attachment: a)
              : LeavesAttachmentWidget(
                  leavesAttachment: a.base64,
                  showHeader: false,
                ),
      ],
    );
  }
}

/// A URL-based attachment card — file name + open action, plus an inline
/// image preview when the file is an image.
class _UrlAttachmentCard extends StatelessWidget {
  const _UrlAttachmentCard({required this.attachment});

  final RequestAttachment attachment;

  Future<void> _open() async {
    final uri = Uri.tryParse(attachment.url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: ColorRes.transparent,
        child: InkWell(
          onTap: _open,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSizes.padding * 0.75),
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              border: Border.all(color: ColorRes.grey5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      attachment.isImage
                          ? Icons.image_outlined
                          : Icons.description_outlined,
                      color: ColorRes.primary,
                      size: AppSizes.iconMd,
                    ),
                    const Sizer(width: 8),
                    Expanded(
                      child: Text(
                        attachment.name.isEmpty
                            ? S.current.attachments
                            : attachment.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Icon(
                      Icons.open_in_new_rounded,
                      color: ColorRes.primary,
                      size: AppSizes.iconSm,
                    ),
                  ],
                ),
                if (attachment.isImage) ...[
                  const Sizer(height: 8),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusMd),
                    child: Image.network(
                      attachment.url,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                              ? child
                              : SizedBox(
                                  height: 180,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ColorRes.primary,
                                    ),
                                  ),
                                ),
                      errorBuilder: (context, error, stack) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
