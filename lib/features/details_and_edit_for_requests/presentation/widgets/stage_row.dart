import 'package:flutter/material.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';

import '../../../../core/constants/colors.dart';

class StageRow extends StatelessWidget {
  final int index;
  final String title;
  final bool isCompleted;
  final bool isActive;
  final bool isPending;
  final bool isLast;
  final Color activeColor;

  const StageRow({
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
              NodeCircle(
                index: index,
                isCompleted: isCompleted,
                isActive: isActive,
                nodeColor: nodeColor,
                activeColor: activeColor,
              ),
              // Connector line (hidden for last item)
              if (!isLast)
                Connector(
                  isCompleted: isCompleted,
                  activeColor: activeColor,
                ),
            ],
          ),
        ),

        const Sizer(width: 14),

        // ── Content ──────────────────────────────────────────────────────
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 6,
              bottom: isLast ? 0 : 28,
            ),
            child: isActive
                ? ActiveLabel(title: title, color: activeColor)
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


class Connector extends StatelessWidget {
  final bool isCompleted;
  final Color activeColor;

  const Connector({required this.isCompleted, required this.activeColor});

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
class ActiveLabel extends StatelessWidget {
  final String title;
  final Color color;

  const ActiveLabel({required this.title, required this.color});

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

class NodeCircle extends StatelessWidget {
  final int index;
  final bool isCompleted;
  final bool isActive;
  final Color nodeColor;
  final Color activeColor;

  const NodeCircle({
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
