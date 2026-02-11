import 'package:flutter/material.dart';
import 'package:shaoni/features/services/presentation/widgets/services_grid_view.dart';

import '../../common/widgets/sizeboxs/Sizer.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Sizer(height: 180),
        const ServicesGridView(),
      ],
    );
  }
}
