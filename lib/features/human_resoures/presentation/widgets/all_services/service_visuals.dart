import 'package:flutter/material.dart';

import '../../../../../core/constants/colors.dart';

/// Visual & behavioral metadata derived from a service's API code.
///
/// Each HR service that comes back from the API has a code like
/// `hr.exit.permission`, `attendance.update`, `study.request`, etc.
/// This class turns that opaque string into something the UI can show:
///   - an icon to render in the leading slot
///   - an accent color
///   - whether tapping the row currently navigates anywhere
///     (we mark the rest as "coming soon" so users get clear feedback)
class ServiceVisuals {
  final IconData icon;
  final Color color;
  final bool isAvailable;

  const ServiceVisuals({
    required this.icon,
    required this.color,
    required this.isAvailable,
  });

  /// Returns the visuals for a given API service code.
  /// Falls back to a neutral document icon for codes we don't recognize.
  static ServiceVisuals forCode(String? code) {
    final c = (code ?? '').toLowerCase();

    /// Anything attendance-related (the screenshot shows `attendance.update`).
    if (c.contains('attendance')) {
      return const ServiceVisuals(
        icon: Icons.fingerprint_rounded,
        color: ColorRes.primary,
        isAvailable: true,
      );
    }

    /// Exit permission / leave the office during work hours.
    if (c.contains('exit') || c.contains('permission') && !c.contains('car')) {
      return const ServiceVisuals(
        icon: Icons.logout_rounded,
        color: ColorRes.primary,
        isAvailable: true,
      );
    }

    /// Study / training requests.
    if (c.contains('study') || c.contains('training')) {
      return const ServiceVisuals(
        icon: Icons.school_rounded,
        color: ColorRes.info,
        isAvailable: true,
      );
    }

    /// Car / vehicle permissions.
    if (c.contains('car') || c.contains('vehicle')) {
      return ServiceVisuals(
        icon: Icons.directions_car_rounded,
        color: ColorRes.staticVioletColor,
        isAvailable: true,
      );
    }

    /// Complaint requests.
    if (c.contains('complaint')) {
      return ServiceVisuals(
        icon: Icons.report_rounded,
        color: ColorRes.error,
        isAvailable: true,
      );
    }

    /// Loans.
    if (c.contains('loan')) {
      return ServiceVisuals(
        icon: Icons.account_balance_wallet_rounded,
        color: ColorRes.success,
        isAvailable: false,
      );
    }

    /// Visa / travel related.
    if (c.contains('visa') || c.contains('travel')) {
      return ServiceVisuals(
        icon: Icons.flight_takeoff_rounded,
        color: ColorRes.info,
        isAvailable: false,
      );
    }

    /// Product / asset request from the warehouse.
    if (c.contains('product')) {
      return ServiceVisuals(
        icon: Icons.inventory_2_rounded,
        color: ColorRes.warning,
        isAvailable: false,
      );
    }

    /// Disposal / scrap.
    if (c.contains('scrap') || c.contains('disposal')) {
      return ServiceVisuals(
        icon: Icons.recycling_rounded,
        color: ColorRes.staticGreenColor,
        isAvailable: false,
      );
    }

    /// Overtime / out-of-hours work.
    if (c.contains('overtime') || c.contains('out')) {
      return ServiceVisuals(
        icon: Icons.access_time_filled_rounded,
        color: ColorRes.warning,
        isAvailable: false,
      );
    }

    /// Start / resume work.
    if (c.contains('start') && c.contains('work')) {
      return ServiceVisuals(
        icon: Icons.play_circle_fill_rounded,
        color: ColorRes.staticGreenColor,
        isAvailable: false,
      );
    }

    /// Vacation / leave.
    if (c.contains('vacation') || c.contains('leave')) {
      return ServiceVisuals(
        icon: Icons.beach_access_rounded,
        color: ColorRes.info,
        isAvailable: false,
      );
    }

    /// HR catch-all.
    if (c.startsWith('hr.')) {
      return ServiceVisuals(
        icon: Icons.badge_rounded,
        color: ColorRes.primary,
        isAvailable: false,
      );
    }

    /// Default fallback.
    return ServiceVisuals(
      icon: Icons.description_rounded,
      color: ColorRes.grey2,
      isAvailable: false,
    );
  }
}
