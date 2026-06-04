import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shaoni/core/local_storage/cache_keys.dart';
import 'package:shaoni/features/auth/data/model/office_model.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/local_storage/cache_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/auth_text_filed.dart';
import '../../attendance/widget/attendance_dropdown_field.dart';

class ApplicantDataWidget extends StatefulWidget {
  final void Function(int officeId, String officeName)? onOfficeChanged;
  final int? initialOfficeId;

  const ApplicantDataWidget({
    super.key,
    this.onOfficeChanged,
    this.initialOfficeId,
  });

  @override
  State<ApplicantDataWidget> createState() => _ApplicantDataWidgetState();
}

class _ApplicantDataWidgetState extends State<ApplicantDataWidget> {
  List<OfficeModel> _offices = [];
  String? _selectedOfficeName;

  void _loadOfficesFromCache() {
    try {
      final decoded =
          jsonDecode(CacheHelper.getString(key: CacheKeys.officesList) ?? '[]');
      if (decoded is! List) return;

      _offices = (decoded)
          .whereType<Map<String, dynamic>>()
          .map((o) => OfficeModel.fromJson(o))
          .toList();

      if (_selectedOfficeName == null && widget.initialOfficeId != null) {
        try {
          _selectedOfficeName =
              _offices.firstWhere((o) => o.id == widget.initialOfficeId).name;
        } catch (_) {}
      }

      if (_selectedOfficeName != null &&
          !_offices.any((o) => o.name == _selectedOfficeName)) {
        _selectedOfficeName = null;
      }
    } catch (_) {
      _offices = [];
    }
  }

  List<DropdownMenuItem<String>> get _officeItems => _offices
      .map((o) => DropdownMenuItem<String>(value: o.name, child: Text(o.name)))
      .toList();

  void _onOfficeSelected(String? value) {
    if (value == null) return;
    setState(() => _selectedOfficeName = value);
    try {
      final selected = _offices.firstWhere((o) => o.name == value);
      widget.onOfficeChanged?.call(selected.id, selected.name);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    _loadOfficesFromCache();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.requestApplicantData,
            style: Theme.of(context).textTheme.headlineMedium),
        AuthTextField(
          hint: S.current.applicantName,
          readOnly: true,
          controller: TextEditingController(
              text: CacheHelper.getString(key: CacheKeys.userName)),
          borderRadius: AppSizes.borderRadiusMd,
          prefixIcon: const Icon(Icons.person),
          validator: (value) =>
              (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
        ),
        AuthTextField(
          hint: S.current.organizationalUnit,
          readOnly: true,
          controller: TextEditingController(
              text: CacheHelper.getString(key: CacheKeys.departmentAddress)),
          borderRadius: AppSizes.borderRadiusMd,
          prefixIcon: const Icon(Icons.home_work),
          validator: (value) =>
              (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
        ),
        const Sizer(height: 18),
        DDropdownField(
          label: '',
          hint: S.current.location,
          icon: Icons.work_outline_rounded,
          value: _selectedOfficeName,
          items: _officeItems,
          onChanged: _onOfficeSelected,
          validator: (value) =>
              (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
        ),
      ],
    );
  }
}
