import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/features/my-requests/domain/entities/current_status.dart';
import 'package:shaoni/features/my-requests/domain/enums_and_extentions/request_enums.dart';

import '../../../../generated/l10n.dart';

class RequestStageCard extends StatelessWidget {
  final CurrentStatus status;

  const RequestStageCard({super.key, required this.status});

  // ─── helpers ────────────────────────────────────────────────────────────────

  /// Convert the backend hex string (#RRGGBB) to a Flutter Color.
  /// Falls back to the app primary if the value is missing/invalid.
  Color get _statusColor {
    final hex = status.colorHex;
    if (hex == null || hex.isEmpty) return ColorRes.primary;
    try {
      final clean = hex.replaceAll('#', '');
      return Color(int.parse('FF$clean', radix: 16));
    } catch (_) {
      return ColorRes.primary;
    }
  }

  /// Localized display name of the current status.
  String _statusName(BuildContext context) {
    final isAr = S.current.localeee != 'en';
    return isAr
        ? (status.nameAr ?? status.nameEn ?? '')
        : (status.nameEn ?? status.nameAr ?? '');
  }

  RequestStatusEnum get _enum => status.getRequestStatusEnum();

  // Determine which numbered step is "active" (0-based).
  int get _activeIndex {
    switch (_enum) {
      case RequestStatusEnum.newRequest:
        return 0;
      case RequestStatusEnum.managerApproval:
        return 1;
      case RequestStatusEnum.hrApproval:
        return 2;
      case RequestStatusEnum.done:
        return 3; // all complete
      case RequestStatusEnum.rejected:
        return -1; // special state
      default:
        return 0;
    }
  }

  bool get _isRejected => _enum == RequestStatusEnum.rejected;

  // ─── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final stages = [
      S.current.NNew,
      S.current.managerApproval,
      S.current.hrManagerApproval,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Container(
        padding: EdgeInsets.all(AppSizes.padding),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          border: Border.all(color: ColorRes.greyForBorders, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row: title + status badge ──────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.requestStage,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                _StatusBadge(
                  label: _statusName(context),
                  color: _isRejected ? ColorRes.error : _statusColor,
                ),
              ],
            ),

            Divider(color: ColorRes.grey4, height: AppSizes.padding * 1.5),
            const Sizer(height: 8),

            // ── Stages ────────────────────────────────────────────────────
            if (_isRejected)
              _RejectedBanner()
            else
              ...List.generate(stages.length, (i) {
                final isCompleted = i < _activeIndex;
                final isActive = i == _activeIndex;
                final isPending = i > _activeIndex;
                final isLast = i == stages.length - 1;

                return _StageRow(
                  index: i,
                  title: stages[i],
                  isCompleted: isCompleted,
                  isActive: isActive,
                  isPending: isPending,
                  isLast: isLast,
                  activeColor: _statusColor,
                );
              }),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Status badge chip
// ─────────────────────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.35), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single stage row
// ─────────────────────────────────────────────────────────────────────────────

class _StageRow extends StatelessWidget {
  final int index;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isLast;
  final Color activeColor;

  const _StageRow({
    required this.index,
    required this.title,
    required this.isCompleted,
    required this.isActive,
    required this.isPending,
    required this.isLast,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color nodeColor = isCompleted || isActive ? activeColor : ColorRes.grey2.withOpacity(0.35);
    final Color textColor = isPending ? ColorRes.grey2 : ColorRes.primaryDark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Timeline column ──────────────────────────────────────────────
        SizedBox(
          width: 36,
          child: Column(
            children: [
              // Node circle
              _NodeCircle(
                index: index,
                isCompleted: isCompleted,
                isActive: isActive,
                nodeColor: nodeColor,
                activeColor: activeColor,
              ),
              // Connector line (hidden for last item)
              if (!isLast)
                _Connector(
                  isCompleted: isCompleted,
                  activeColor: activeColor,
                ),
            ],
          ),
        ),

        const SizedBox(width: 14),

        // ── Content ──────────────────────────────────────────────────────
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 6,
              bottom: isLast ? 0 : 28,
            ),
            child: isActive
                ? _ActiveLabel(title: title, color: activeColor)
                : Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: textColor,
                          fontWeight: isCompleted
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                  ),
          ),
        ),

        // ── Check icon for completed ──────────────────────────────────────
        if (isCompleted)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              Icons.check_circle_rounded,
              color: activeColor,
              size: 18,
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Node circle
// ─────────────────────────────────────────────────────────────────────────────

class _NodeCircle extends StatelessWidget {
  final int index;
  final bool isCompleted;
  final bool isActive;
  final Color nodeColor;
  final Color activeColor;

  const _NodeCircle({
    required this.index,
    required this.isCompleted,
    required this.isActive,
    required this.nodeColor,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    // Completed → solid filled circle with check
    if (isCompleted) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activeColor,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      );
    }

    // Active → double-ring "pulse" style
    if (isActive) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: activeColor.withOpacity(0.15),
          border: Border.all(color: activeColor, width: 2),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: activeColor,
            ),
          ),
        ),
      );
    }

    // Pending → outlined circle with step number
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(color: ColorRes.grey2.withOpacity(0.35), width: 2),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: ColorRes.grey2.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Connector line between steps
// ─────────────────────────────────────────────────────────────────────────────

class _Connector extends StatelessWidget {
  final bool isCompleted;
  final Color activeColor;

  const _Connector({required this.isCompleted, required this.activeColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 36,
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: isCompleted ? activeColor : ColorRes.grey2.withOpacity(0.25),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Active step label with tinted pill background
// ─────────────────────────────────────────────────────────────────────────────

class _ActiveLabel extends StatelessWidget {
  final String title;
  final Color color;

  const _ActiveLabel({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Rejected banner (replaces stage list when request is rejected)
// ─────────────────────────────────────────────────────────────────────────────

class _RejectedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: ColorRes.error.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorRes.error.withOpacity(0.25), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.cancel_rounded, color: ColorRes.error, size: 22),
          const SizedBox(width: 10),
          Text(
            S.current.rejectedRequest,
            style: TextStyle(
              color: ColorRes.error,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
