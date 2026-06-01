import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../controllers/services_cubit.dart';
import '../widgets/services_grid_view.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServicesCubit>(
      create: (_) => serviceLocator<ServicesCubit>()..getAllServices(),
      child: const ServicesGridView(),
    );
  }
}
