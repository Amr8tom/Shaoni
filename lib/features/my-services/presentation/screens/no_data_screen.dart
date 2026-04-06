import 'package:flutter/material.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        showBackArrow: true,
      ),
      body: CustomUI.noData(),
    );
  }
}
