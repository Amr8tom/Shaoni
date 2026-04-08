import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/common/custom_ui.dart';
import 'package:shaoni/common/widgets/sizeboxs/Sizer.dart';
import 'package:shaoni/core/extentions/navigation_extension.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../generated/l10n.dart';
import '../../domain/use_cases/approve_request_use_case.dart';
import '../controller/my_requests_cubit.dart';


class AcceptRequestButton extends StatelessWidget {
  final String requestID;
  const AcceptRequestButton({super.key, required this.requestID});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyRequestsCubit, MyRequestsState>(
  builder: (context, state) {
    if (state.status.isLoading){
      return const Center(child: CircularProgressIndicator(color: ColorRes.primary,));
    }else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.padding * 1.8),
        child: Row(
          children: [
            /// accept request button
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  context.read<MyRequestsCubit>().acceptRequest(
                      params: AcceptRequestParams(
                          id: int.parse(requestID),
                          statusCode: 6,
                          comment: context
                              .read<MyRequestsCubit>()
                              .commentController
                              .text));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSizes.xxl),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      height: AppSizes.heightcontainer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppSizes.xxl),
                        ),
                        color: ColorRes.primary.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          S.current.acceptRequest,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: ColorRes.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Sizer(width: AppSizes.padding),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  context.read<MyRequestsCubit>().acceptRequest(
                      params: AcceptRequestParams(
                          id: int.parse(requestID),
                          statusCode: 8,
                          comment: context
                              .read<MyRequestsCubit>()
                              .commentController
                              .text));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSizes.xxl),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      height: AppSizes.heightcontainer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppSizes.xxl),
                        ),
                        color: ColorRes.grey.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          S.current.rejectRequest,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: ColorRes.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }}, listener: (BuildContext context, MyRequestsState state) {
    if(state.status.isSuccess){
      context.pushNamedAndRemoveUntil(DRoutesName.navigationMenuRoute, predicate: (Route<dynamic> route) { return false; });
    }
    },
);
  }
}
