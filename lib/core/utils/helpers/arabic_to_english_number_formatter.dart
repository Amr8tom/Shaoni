import 'package:flutter/services.dart';

class ArabicToEnglishNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    const arabicAndPersian = [
      '٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩', // Arabic
      '۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', // Persian
    ];
    const english = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];

    String newText = newValue.text;
    for (int i = 0; i < arabicAndPersian.length; i++) {
      newText = newText.replaceAll(arabicAndPersian[i], english[i]);
    }

    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
      composing: TextRange.empty,
    );
  }
}
