import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shaoni/core/local_storage/session_storage/session_storage.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/auth/domain/entities/office.dart';
import 'package:shaoni/features/auth/data/model/office_model.dart';
import '../../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../../core/constants/app_sizes.dart';
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
  List<OfficeEntity> _offices = [];
  String? _selectedOfficeName;
  final SessionStorage _sessionStorage = serviceLocator<SessionStorage>();

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
        const Sizer(
          height: 8,
        ),
        AuthTextField(
          hint: S.current.applicantName,
          readOnly: true,
          controller: TextEditingController(text: _sessionStorage.userName),
          borderRadius: AppSizes.borderRadiusMd,
          prefixIcon: const Icon(Icons.person),
          validator: (value) =>
              (value?.isEmpty ?? true) ? S.current.pleaseEndterValue : null,
        ),
        const Sizer(height: 8),
        AuthTextField(
          hint: S.current.organizationalUnit,
          readOnly: true,
          controller:
              TextEditingController(text: _sessionStorage.departmentAddress),
          borderRadius: AppSizes.borderRadiusMd,
          prefixIcon: const Icon(Icons.home_work),
        ),
        const Sizer(height: 8),
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
        if (_sessionStorage.registrationNumber?.isNotEmpty ?? false) ...[
          const Sizer(height: 8),
          AuthTextField(
            hint: S.current.registrationNumber,
            readOnly: true,
            controller:
                TextEditingController(text: _sessionStorage.registrationNumber),
            borderRadius: AppSizes.borderRadiusMd,
            prefixIcon: const Icon(Icons.assignment_ind_outlined),
          ),
        ],
        if ((_sessionStorage.jobNumber?.isNotEmpty ?? false) ||
            (_sessionStorage.jobTitle?.isNotEmpty ?? false)) ...[
          const Sizer(height: 8),
          Row(
            children: [
              if (_sessionStorage.jobNumber?.isNotEmpty ?? false)
                Expanded(
                  child: AuthTextField(
                    hint: S.current.jobNumber,
                    readOnly: true,
                    controller:
                        TextEditingController(text: _sessionStorage.jobNumber),
                    borderRadius: AppSizes.borderRadiusMd,
                    prefixIcon: const Icon(Icons.badge_outlined),
                  ),
                ),
              if ((_sessionStorage.jobNumber?.isNotEmpty ?? false) &&
                  (_sessionStorage.jobTitle?.isNotEmpty ?? false))
                const Sizer(width: 12),
              if (_sessionStorage.jobTitle?.isNotEmpty ?? false)
                Expanded(
                  child: AuthTextField(
                    hint: S.current.jobTitle,
                    readOnly: true,
                    controller:
                        TextEditingController(text: _sessionStorage.jobTitle),
                    borderRadius: AppSizes.borderRadiusMd,
                    prefixIcon: const Icon(Icons.work_outline),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  void _loadOfficesFromCache() {
    try {
      final decoded = jsonDecode(_sessionStorage.officesList ?? '[]');
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
}
