import 'package:flutter/material.dart';
import '../../../../../core/constants/colors.dart';

/// Bold field title shared by the loan request data sections.
class LoanFieldLabel extends StatelessWidget {
  final String text;

  const LoanFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorRes.black,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
