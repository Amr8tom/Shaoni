import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/widgets/sized_boxes/sizer.dart';
import 'package:shaoni/core/routing/route_names.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../generated/l10n.dart';
import '../controller/edit/edit_cubit.dart';

class EditRequestButton extends StatelessWidget {
  final String requestID;
  final String serviceCode;

  const EditRequestButton({
    super.key,
    required this.requestID,
    required this.serviceCode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditCubit, EditState>(
      listener: (context, state) {
        if (state.isEditRequestLoaded) {
          SnackBar(
            content: Text(state.editResponse?.message ?? S.current.success),
            backgroundColor: ColorRes.success,
            behavior: SnackBarBehavior.floating,
          );
          context.pushNamedAndRemoveUntil(DRoutesName.navigationMenuRoute,
              predicate: (route) => false);
        } else if (state.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? S.current.notImplementedYet),
              backgroundColor: ColorRes.staticRedColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: ColorRes.primary),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.8),
          child: GestureDetector(
            onTap: () {
              final id = int.tryParse(requestID);
              if (id == null) return;

              context.read<EditCubit>().editRequest(
                    requestId: id,
                    serviceCode: serviceCode,
                  );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(AppSizes.xxl)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  height: AppSizes.heightcontainer,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppSizes.xxl)),
                    color: ColorRes.staticBlueColor.withOpacity(0.75),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.edit_rounded,
                        color: ColorRes.white,
                        size: 18,
                      ),
                      const Sizer(width: 8),
                      Text(
                        S.current.editRequest,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: ColorRes.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
