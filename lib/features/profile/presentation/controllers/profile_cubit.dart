import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:shaoni/core/utils/enums/general_status.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  final GeneralStatus status;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  ProfileCubit({this.status = GeneralStatus.initialized})
    : super(ProfileState());
}
