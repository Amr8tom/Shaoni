import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/features/my-requests/presentation/controller/my_requests_cubit.dart';

import '../../../../common/widgets/sizeboxs/Sizer.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../home/presentation/widgets/my_requests_grid_view.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: SizedBox(
        height: AppSizes.fullHeight * 0.79,
        child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
          builder: (context, state) {
            return const MyRequestGridView();
          },
        ),
      ),
    );
  }
}
