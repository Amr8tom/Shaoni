import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';

class PassportInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String value;

  const PassportInputWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.value,
  });

  @override
  State<PassportInputWidget> createState() => _PassportInputWidgetState();
}

class _PassportInputWidgetState extends State<PassportInputWidget> {
  late TextEditingController _confirmController;

  @override
  void initState() {
    super.initState();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorRes.blueColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.md),
        border: Border.all(color: ColorRes.blueColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel(S.current.passNo),
          _buildTextField(
            controller: widget.controller,
            hintText: S.current.typePass,
            onChanged: widget.onChanged,
          ),
          _buildFieldLabel(S.current.confirmPass),
          _buildTextField(
            controller: _confirmController,
            hintText: S.current.typePass,
            onChanged: (value) {}, // Handle confirm password if needed
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppSizes.md, AppSizes.md, AppSizes.md, AppSizes.xs),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppSizes.md,
          fontWeight: FontWeight.w600,
          color: ColorRes.primary,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, AppSizes.md),
      child: Container(
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(AppSizes.sm),
          border: Border.all(
            color: widget.value.isNotEmpty 
              ? ColorRes.blueColor.withValues(alpha: 0.5)
              : ColorRes.grey.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorRes.grey.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: EdgeInsets.all(AppSizes.md),
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: ColorRes.grey.withValues(alpha: 0.7),
              fontSize: AppSizes.md,
            ),
          ),
          style: TextStyle(
            fontSize: AppSizes.md,
            color: ColorRes.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
