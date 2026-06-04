import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaoni/core/service_locator/service_locator.dart';
import 'package:shaoni/features/delete_account/presentation/controllers/delete_account_cubit.dart';
import 'package:shaoni/features/delete_account/presentation/widgets/delete_my_account_body.dart';
import '../../../../../generated/l10n.dart';
import '../../../common/widgets/appbar/appbar.dart';

class DeleteMyAccountScreen extends StatelessWidget {
  const DeleteMyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<DeleteAccountCubit>(),
      child: Scaffold(
        appBar: DAppBar(title: S.current.deleteAccount, arrowBackColor: true),
        body: const DeleteMyAccountBody(),
      ),
    );
  }
}
