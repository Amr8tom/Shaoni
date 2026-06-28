import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../common/widgets/sized_boxes/sizer.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/helpers/arabic_to_english_number_formatter.dart';

class AuthTextField extends StatefulWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;
  final bool isDate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool readOnly;
  final Color? borderColor, backgroundColor, formColor;
  final double? borderRadius;

  /// Optional overrides. When provided they take precedence over the type
  /// flags (isEmail/isPhone/isDate) so callers can build numeric or decimal
  /// fields without introducing a new flag.
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AuthTextField({
    super.key,
    this.label,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
    this.isDate = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.onChanged,
    this.borderColor,
    this.readOnly = false,
    this.borderRadius,
    this.backgroundColor,
    this.formColor,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorRes.black,
                    fontSize: AppSizes.fontSizeSm / 1.1,
                  ),
            ),
            const Sizer(height: 8),
          ],

          /// Text Field
          TextFormField(
            controller: widget.controller,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            obscureText: widget.isPassword && !_showPassword,
            keyboardType: _getKeyboardType(),
            inputFormatters: _getFormatters(),
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorRes.grey2.withValues(alpha: 0.7),
                    fontSize: AppSizes.fontSizeSm * 1,
                  ),
              prefixIcon: widget.prefixIcon ?? _getDefaultIcon(),
              suffixIcon: widget.suffixIcon ?? _getSuffixIcon(),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.spaceBetweenIcon * 3,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppSizes.borderRadiusXXLg,
                ),
                borderSide: const BorderSide(color: ColorRes.primary, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppSizes.borderRadiusXXLg,
                ),
                borderSide: BorderSide(
                  color: widget.borderColor ?? ColorRes.greyF707340,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppSizes.borderRadiusXXLg,
                ),
                borderSide: const BorderSide(color: ColorRes.primary, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppSizes.borderRadiusXXLg,
                ),
                borderSide: const BorderSide(color: ColorRes.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppSizes.borderRadiusXXLg,
                ),
                borderSide: const BorderSide(color: ColorRes.error, width: 1),
              ),
              filled: true,
              fillColor: widget.formColor ?? ColorRes.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _getDefaultIcon() {
    if (widget.isEmail) {
      return const Icon(Icons.email_outlined, color: ColorRes.grey);
    }
    if (widget.isPassword) {
      return const Icon(Icons.lock_outline, color: ColorRes.grey);
    }
    if (widget.isPhone) {
      return const Icon(Icons.phone_outlined, color: ColorRes.grey);
    }
    if (widget.isDate) {
      return const Icon(Icons.calendar_today_outlined, color: ColorRes.grey);
    }
    return null;
  }

  Widget? _getSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _showPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorRes.grey,
        ),
        onPressed: () {
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    }
    if (widget.isDate) {
      return const Icon(Icons.add, color: ColorRes.primary);
    }
    return null;
  }

  TextInputType _getKeyboardType() {
    if (widget.keyboardType != null) return widget.keyboardType!;
    if (widget.isEmail) return TextInputType.emailAddress;
    if (widget.isPhone) return TextInputType.phone;
    if (widget.isDate) return TextInputType.datetime;
    return TextInputType.text;
  }

  List<TextInputFormatter>? _getFormatters() {
    if (widget.inputFormatters != null) return widget.inputFormatters;
    if (widget.isPhone) {
      return [
        ArabicToEnglishNumberFormatter(),
        FilteringTextInputFormatter.digitsOnly,
      ];
    }
    if (widget.isDate) {
      return [DateFormatter()];
    }
    return null;
  }
}

// Simple date formatter for MM-DD-YYY format
class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formatted = '';
    for (int i = 0; i < text.length && i < 8; i++) {
      if (i == 2 || i == 4) formatted += '-';
      formatted += text[i];
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
