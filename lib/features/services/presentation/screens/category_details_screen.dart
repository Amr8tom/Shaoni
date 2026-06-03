import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/common/widgets/appbar/appbar.dart';
import 'package:shaoni/core/constants/app_sizes.dart';
import 'package:shaoni/core/constants/colors.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entity/service.dart';
import '../widgets/all_services/service_grid_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String title;
  final List<Service> services;

  const CategoryDetailsScreen(
      {super.key, required this.title, required this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.grey6,
      appBar: DAppBar(
        showBackArrow: true,
        title: title,
        fontSize: AppSizes.fontSizeMd,
        actions: const [],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.padding,
            ),
            child: AnimationLimiter(
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.only(bottom: AppSizes.padding * 2),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  if (services.isEmpty)
                    return CustomUI.emptyData(message: S.current.noData);
                  final service = services[index];
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 400),
                    child: ScaleAnimation(
                      scale: 0.95,
                      child: FadeInAnimation(
                        child: ServiceGridCard(
                          service: service,
                          onTap: () => _onServiceTap(context, service),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }

  static void _onServiceTap(BuildContext context, Service service) {
    final code = service.nameEn ?? '';
    switch (code) {
      case 'hr.exit.permission':
        context.pushNamed(
          DRoutesName.requestCertainService,
        );
        return;
      case 'attendance.update':
        context.pushNamed(DRoutesName.missingAttendanceHistory);
        return;
      case 'study.request':
        context.pushNamed(DRoutesName.createStudyRequestRoute);
        return;
      case 'car.permission':
        context.pushNamed(DRoutesName.createCarPermissionRoute);
        return;
      case 'complaint.request':
        context.pushNamed(DRoutesName.createComplaintRequestRoute);
        return;
      case 'start.work':
        context.pushNamed(DRoutesName.createStartWorkRoute);
        return;
      case 'experience.certificate':
        context.pushNamed(DRoutesName.createExperienceCertificateRoute);
        return;
      case 'upgrade.medical.insurance':
        context.pushNamed(DRoutesName.createMedicalInsuranceRoute);
        return;
      case 'training.request':
        context.pushNamed(DRoutesName.createTrainingRequestRoute);
        return;
      case 'product.request':
        context.pushNamed(DRoutesName.createProductOrderRoute);
        return;
      case 'id.renewal.request':
        context.pushNamed(DRoutesName.createIDDocumentRoute);
      case 'outside.working':
        context.pushNamed(DRoutesName.createOutsideWorkingRoute);
        return;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.notImplementedYet),
            backgroundColor: ColorRes.grey2,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }
}
